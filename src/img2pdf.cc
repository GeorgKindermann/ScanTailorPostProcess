#include <iostream>
#include <fstream>
#include <bit>
#include <filesystem>
#include <string>
#include <regex>
#include <vector>
#include <algorithm>

int getJpgWH(std::ifstream &infile, uint16_t &w, uint16_t &h, uint8_t &nBits, uint8_t &nColors) {
  uint16_t u;
  unsigned char c;
  infile.read(reinterpret_cast<char *>(&u), sizeof(u));
  if(u != 0xd8ff) std::cerr << "Not a jpg marker\n";
  size_t n{0};
  infile.read(reinterpret_cast<char *>(&c), sizeof(c));
  while(!infile.eof()) {
    while (c != 0xff) {
      ++n;
      infile.read(reinterpret_cast<char *>(&c), sizeof(c));
    }
    if(n > 0) std::cerr << "Garbage in jpg\n";
    while (c == 0xff) infile.read(reinterpret_cast<char *>(&c), sizeof(c));
    if(c >= 0xc0 && c <= 0xcf && c != 0xc4 && c != 0xcc) { //?c8
      infile.seekg(2, std::ios_base::cur);
      infile.read(reinterpret_cast<char *>(&nBits), sizeof(nBits));
      infile.read(reinterpret_cast<char *>(&h), sizeof(h));
      h = std::byteswap(h);
      infile.read(reinterpret_cast<char *>(&w), sizeof(w));
      w = std::byteswap(w);
      infile.read(reinterpret_cast<char *>(&nColors), sizeof(nColors));
      return 0;
    } else {
      infile.read(reinterpret_cast<char *>(&u), sizeof(u));
      u = std::byteswap(u);
      if(u<2) std::cerr << "Jpg length error\n";
      infile.seekg(u-2, std::ios_base::cur);
      infile.read(reinterpret_cast<char *>(&c), sizeof(c));
    }
  }
  return 1;
}

std::string getFirstFileName(std::string wildcard) {
  std::string path{std::regex_replace(wildcard, std::regex("[^/]*$"), "")};
  if(path == "") path = "./";
  for(const auto & entry : std::filesystem::directory_iterator(path)) {
    if(std::regex_search(entry.path().generic_string(), std::regex(wildcard))) return entry.path().generic_string();
  }
  return "";
}

int main(int argc, char* argv[]) {
  if(argc < 3) {
    std::cerr << "Too few arguments\n";
    std::cerr << "img2pdf Userunit basenameOfJBIG2Files originalTifFiles\n";
    return(0);
  }
  std::ifstream infile;

  std::string jb2(argv[2]);
  std::string jbFS(jb2 + ".sym");
  bool jbSym = std::filesystem::exists(jbFS);
  
  std::vector<std::string> jbF;
  for (const auto & entry : std::filesystem::directory_iterator(std::regex_replace(jb2, std::regex("[^/]*$"), ""))) {
    if(std::regex_search(entry.path().generic_string(), std::regex(jb2 + ".[0-9]+"))) jbF.push_back(entry.path());
  }
  if(jbF.size() != static_cast<size_t>(argc - 3)) {
    std::cerr << "Number of names does not match JBIG2 number of files\n";
    return(0);
  }
  std::sort(jbF.begin(), jbF.end());

  size_t nc = 0;
  std::vector<std::string> cF;
  for(int i=3; i<argc; ++i) {
    std::string path{std::filesystem::path(argv[i]).parent_path()};
    if(path == "") path = ".";
    std::string fname{std::filesystem::path(argv[i]).stem()};
    std::string t{path + "/c/" + fname + "_t[0-9]+_[0-9]+_s[0-9]+_[0-9]+\\.jpg"};
    t = getFirstFileName(t);
    cF.push_back(t);
    if(t != "") ++nc;
  }

  std::vector<size_t> sym;
  //Changed outfile to std::cout
  //std::ofstream outfile("/tmp/pdfx.pdf", std::ofstream::binary);
  std::cout << R"(%PDF-1.6
)";
  sym.push_back(std::cout.tellp());
  std::cout << R"(1 0 obj <</Type /Catalog
/Pages 2 0 R>>
endobj
)";
  sym.push_back(std::cout.tellp());
  std::cout << R"(2 0 obj <</Type /Pages
/Count )" << cF.size() << R"(
/Kids [)";
  size_t kid = jbSym ? 6 : 5;
  for(size_t i=0; i<cF.size(); ++i) {
    if(i>0) std::cout << " ";
    if(cF[i] != "") ++kid;
    std::cout << kid << " 0 R";
    kid += 3;
  }
  std::cout << R"(]>>
endobj
)";
  size_t obj = 2;
  if(jbSym) {
    ++obj;
    sym.push_back(std::cout.tellp());
    std::cout << R"(3 0 obj <</Length )";
    std::cout << std::filesystem::file_size(jbFS);
    std::cout << R"(>>
stream
)";
  infile.open(jbFS, std::ios::binary);
  std::cout << infile.rdbuf();
  infile.close();
  std::cout << R"(
endstream
endobj
)";
  }

  for(size_t i=0; i<jbF.size(); ++i) {
    uint32_t w, h;
    infile.open(jbF[i], std::ios::binary);
    infile.seekg(11);
    infile.read(reinterpret_cast<char *>(&w), sizeof(w));
    w = std::byteswap(w);
    infile.read(reinterpret_cast<char *>(&h), sizeof(h));
    h = std::byteswap(h);
    sym.push_back(std::cout.tellp());
    std::cout << ++obj;
    std::cout << R"( 0 obj <</Subtype /Image 
/Width )" << w << " /Height " << h << R"(
/ImageMask true
)";
    std::cout << (jbSym ? R"(/Filter /JBIG2Decode /DecodeParms << /JBIG2Globals 3 0 R >>)" : R"(/Filter /JBIG2Decode)");
    std::cout << R"(
/Length )";
    std::cout << std::filesystem::file_size(jbF[i]);
    std::cout << R"(>>
stream
)";
    infile.seekg(0);
    std::cout << infile.rdbuf();
    infile.close();
    std::cout << R"(
endstream
endobj
)";

    if(cF[i] != "") {
      uint16_t w, h;
      uint8_t nBits, nColors;
      infile.open(cF[i], std::ios::binary);
      getJpgWH(infile, w, h, nBits, nColors);
      sym.push_back(std::cout.tellp());
      std::cout << ++obj;
      std::cout << R"( 0 obj <</Subtype /Image 
/Width )" << w << " /Height " << h << R"(
/Filter /DCTDecode
/ColorSpace /Device)" << (nColors==1 ? "Gray" : "RGB") << R"(
/BitsPerComponent )" << static_cast<unsigned int>(nBits) << R"(
/Length )";
      std::cout << std::filesystem::file_size(cF[i]);
      std::cout << R"(>>
stream
)";
      infile.seekg(0);
      std::cout << infile.rdbuf();
      infile.close();
      std::cout << R"(
endstream
endobj
)";
    }

  std::stringstream ss;
  if(cF[i] != "") {
    std::smatch m;
    std::regex_match(cF[i], m, std::regex(".*_t([0-9]+)_([0-9]+)_s([0-9]+)_([0-9]+).*"));
    ss << "q " << m[3] << " 0 0 " << m[4] << " " << std::stoi(m[1]) + 1 << " " << std::stoi(m[2]) + 1 <<" cm /F Do Q\n";
  }
  //ss << "0 0 0 rg\n"; //setzt nonstroking colour auf schwarz - nicht unbedingt noetig
  ss << "q " << w << " 0 0 " << h << " 1 1 cm /B Do Q";
  sym.push_back(std::cout.tellp());
  std::cout << ++obj;
  std::cout << R"( 0 obj <</Length )" << ss.tellp() << ">>\n" << "stream\n";
  std::cout << ss.rdbuf();
  std::cout << R"(
endstream
endobj
)";

  sym.push_back(std::cout.tellp());
  std::cout << ++obj;
  std::cout << R"( 0 obj <</Type /Page /Parent 2 0 R /UserUnit )" << argv[1] << R"( /MediaBox [0 0 )"
   << w+2 << " " << h+2 << R"(]
/Contents )" << obj-1 << R"( 0 R
/Resources <</XObject <</B )" << (obj - (cF[i] == "" ? 2 : 3)) << R"( 0 R)";
  if(cF[i] != "") std::cout << R"(
/F )" << obj - 2 << " 0 R";
std::cout << R"(>> >> >>
endobj
)";
  }
  size_t xref = std::cout.tellp();
  std::cout << "xref\n0 " << obj+1;
  std::cout << "\n0000000000 65535 f\n";
  for(const size_t& x : sym) std::cout << std::setfill('0') << std::setw(10) << x << " 00000 n\n";
  std::cout << R"(trailer <</Size )" << obj+1 << R"(
/Root 1 0 R>>
startxref
)" << xref << R"(
%%EOF
)";
  
  //outfile.close();
}
