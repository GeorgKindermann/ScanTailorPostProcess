#include <iostream>
#include <string>
#include <filesystem>
#include "tiffio.h"

int main(int argc, char* argv[]) {
  TIFF* tif = TIFFOpen(argv[1], "r");
  if(tif) {
    std::string path{std::filesystem::path(argv[1]).parent_path()};
    if(path == "") path = ".";
    std::string fname{std::filesystem::path(argv[1]).stem()};
    std::filesystem::create_directories(path + "/bw");
    std::filesystem::create_directories(path + "/c");
    std::filesystem::create_directories(path + "/c2");
    uint32_t w, h;
    TIFFGetField(tif, TIFFTAG_IMAGEWIDTH, &w);
    TIFFGetField(tif, TIFFTAG_IMAGELENGTH, &h);
    uint32_t* raster;
    raster = (uint32_t*) _TIFFmalloc(w * h * sizeof (uint32_t));
    if(raster != NULL) {
      if(TIFFReadRGBAImage(tif, w, h, raster, 0)) {
	
	size_t w8 = (w + 7) / 8;
	uint8_t* bw;
	bw = (uint8_t*) _TIFFmalloc(w8 * h * sizeof (uint8_t));
	for(size_t y = 0; y < h; ++y) {
	  for(size_t x = 0; x < w; ++x) {
	    bw[y*w8 + x/8] <<= 1;
	    if(raster[y*w+x] == 0xff000000) {
	      bw[y*w8 + x/8] |= 1;
	      raster[y*w+x] = 0xffffffff;
	    }
	  }
	  bw[y*w8 + (w-1)/8] <<= w8*8 - w;
	}
	
	uint32_t yl = h-1;
	uint32_t yh = 0;
	uint32_t xl = w-1;
	uint32_t xh = 0;
	for(size_t y = 0; y < h; ++y) {
	  for(size_t x = 0; x < w; ++x) {
	    if(raster[y*w+x] != 0xffffffff) {
	      if(yl > y) yl = y;
	      if(yh < y) yh = y;
	      if(xl > x) xl = x;
	      if(xh < x) xh = x;
	    }
	  }
	}

	TIFF *image = TIFFOpen((path + "/bw/" + fname + ".tif").c_str(), "w");
	TIFFSetField(image, TIFFTAG_IMAGEWIDTH, w);
	TIFFSetField(image, TIFFTAG_IMAGELENGTH, h);
	TIFFSetField(image, TIFFTAG_BITSPERSAMPLE, 1);
	TIFFSetField(image, TIFFTAG_SAMPLESPERPIXEL, 1);
	TIFFSetField(image, TIFFTAG_ROWSPERSTRIP, 1);
	TIFFSetField(image, TIFFTAG_COMPRESSION, COMPRESSION_CCITTFAX4);
	for (size_t y = 0; y < h; ++y) {
	  TIFFWriteScanline(image, &bw[(h-1-y)*w8], y, 0);
	}
	TIFFClose(image);
	_TIFFfree(bw);

	if(xl <= xh && yl <= yh) {
	  image = TIFFOpen((path + "/c/" + fname + "_t" +
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
	  
	  image = TIFFOpen((path + "/c2/" + fname + ".tif").c_str(), "w");
	  TIFFSetField(image, TIFFTAG_IMAGEWIDTH, w);
	  TIFFSetField(image, TIFFTAG_IMAGELENGTH, h);
	  TIFFSetField(image, TIFFTAG_BITSPERSAMPLE, 8);
	  TIFFSetField(image, TIFFTAG_SAMPLESPERPIXEL, 3);
	  TIFFSetField(image, TIFFTAG_ROWSPERSTRIP, 1);
	  TIFFSetField(image, TIFFTAG_PHOTOMETRIC, 2);
	  TIFFSetField(image, TIFFTAG_COMPRESSION, COMPRESSION_LZW);
	  c = (unsigned char*) _TIFFmalloc(w * 3 * sizeof (c));
	  for(size_t y = 0; y < h; ++y) {
	    for(size_t x = 0; x < w; ++x) {
	      unsigned char* t = (unsigned char*)&raster[y*w + x];
	      for(size_t i=0; i<3; ++i) c[x*3+i] = t[i];
	    }
	    TIFFWriteScanline(image, c, h-1-y, 0);
	  }
	  TIFFClose(image);
	  _TIFFfree(c);
	  
	}
	
      }
      _TIFFfree(raster);
    }
    TIFFClose(tif);
  }
}
