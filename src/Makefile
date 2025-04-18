CC      = g++
CFLAGS  = -Wall -O3 -march=native -funroll-loops -flto -pedantic -std=c++23 -flto=auto

all: splitBWC img2pdf subImages

splitBWC: splitBWC.cc
	$(CC) $(CFLAGS) splitBWC.cc -osplitBWC -ltiff
	strip splitBWC

img2pdf: img2pdf.cc
	$(CC) $(CFLAGS) img2pdf.cc -oimg2pdf
	strip img2pdf

subImages: subImages.cc
	$(CC) $(CFLAGS) subImages.cc -osubImages -ltiff
	strip subImages
