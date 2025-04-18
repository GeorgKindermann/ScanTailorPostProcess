#include <iostream>
#include <string>
#include <filesystem>
#include <vector>
#include <cstdlib>
#include <algorithm>
#include "tiffio.h"

int writeTiff(uint32_t* raster, std::string path, std::string fname, uint32_t w, uint32_t hl, uint32_t hh, uint32_t wl, uint32_t wh) {
  int ret{1};
  uint32_t yl = hh;
  uint32_t yh = hl;
  uint32_t xl = wh;
  uint32_t xh = wl;
  for(size_t y = hl; y <= hh; ++y) {
    for(size_t x = wl; x <= wh; ++x) {
      if(raster[y*w+x] != 0xffffffff) {
	if(yl > y) yl = y;
	if(yh < y) yh = y;
	if(xl > x) xl = x;
	if(xh < x) xh = x;
      }
    }
  }
  if(xl <= xh && yl <= yh) {
    TIFF *image = TIFFOpen((path + "/cs/" + fname + "_t" +
			    std::to_string(xl) + "_" + std::to_string(yl) +
    "_s" + std::to_string(1 + xh - xl) + "_" + std::to_string(1 + yh - yl) +
			    ".tif").c_str(), "w");
    TIFFSetField(image, TIFFTAG_IMAGEWIDTH, 1+xh-xl);
    TIFFSetField(image, TIFFTAG_IMAGELENGTH, 1+yh-yl);
    TIFFSetField(image, TIFFTAG_BITSPERSAMPLE, 8);
    TIFFSetField(image, TIFFTAG_SAMPLESPERPIXEL, 3);
    TIFFSetField(image, TIFFTAG_ROWSPERSTRIP, 1);
    TIFFSetField(image, TIFFTAG_PHOTOMETRIC, 2);
    TIFFSetField(image, TIFFTAG_COMPRESSION, COMPRESSION_LZW);
    unsigned char* c;
    c = (unsigned char*) _TIFFmalloc((1+xh-xl) * 3 * sizeof (c));
    for(size_t y = yl; y <= yh; ++y) {
      for(size_t x = xl; x <= xh; ++x) {
	unsigned char* t = (unsigned char*)&raster[y*w + x];
	for(size_t i=0; i<3; ++i) c[(x-xl)*3+i] = t[i];
      }
      TIFFWriteScanline(image, c, yh-y, 0);
    }
    TIFFClose(image);
    _TIFFfree(c);
    ret = 0;
  }
  return ret;
}

int main(int argc, char* argv[]) {
  if(argc < 2) {
    std::cerr << "Too few arguments\n";
    std::cerr << "subImages tiffile [mode]\n";
    return(0);
  }
  int mode{0};
  if(argc > 2) mode = std::atoi(argv[2]);
  TIFF* tif = TIFFOpen(argv[1], "r");
  if(tif) {
    std::string path{std::filesystem::path(argv[1]).parent_path().parent_path()};
    if(path == "") path = "..";
    std::string fname{std::filesystem::path(argv[1]).stem()};
    std::filesystem::create_directories(path + "/cs");
    uint32_t w, h;
    TIFFGetField(tif, TIFFTAG_IMAGEWIDTH, &w);
    TIFFGetField(tif, TIFFTAG_IMAGELENGTH, &h);
    uint32_t* raster;
    raster = (uint32_t*) _TIFFmalloc(w * h * sizeof (uint32_t));
    if(raster != NULL) {
      if(TIFFReadRGBAImage(tif, w, h, raster, 0)) {
	if(mode == 1) {
	  std::vector<bool> wb(w, false);
	  std::vector<bool> hb(h, false);
	  for(size_t y = 0; y < h; ++y) {
	    for(size_t x = 0; x < w; ++x) {
	      if(raster[y*w+x] != 0xffffffff) {
		wb[x] = true;
		hb[y] = true;
	      }
	    }
	  }
	  std::vector<uint32_t> vx{0};
	  for(size_t x = 1; x < w-1; ++x) {
	    if(!wb[x-1] && wb[x]) vx.push_back(x);
	  }
	  vx.push_back(w);
	  vx.erase(std::unique(vx.begin(), vx.end()), vx.end());
	  std::vector<uint32_t> vy{0};
	  for(size_t y = 1; y < h-1; ++y) {
	    if(!hb[y-1] && hb[y]) vy.push_back(y);
	  }
	  vy.push_back(h);
	  vy.erase(std::unique(vy.begin(), vy.end()), vy.end());
	  for(size_t x=1; x<vx.size(); ++x) {
	    for(size_t y=1; y<vy.size(); ++y) {
	      writeTiff(raster, path, fname, w, vy[y-1], vy[y]-1, vx[x-1], vx[x]-1);
	    }
	  }
	} else {
	  writeTiff(raster, path, fname, w, 0, h-1, 0, w-1);
	}
      }
      _TIFFfree(raster);
    }
    TIFFClose(tif);
  }
}
