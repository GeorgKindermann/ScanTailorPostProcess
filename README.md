Compare different methods when post-processing the output from [Scantailor-Experimental](https://github.com/ImageProcessing-ElectronicPublications/scantailor-experimental).

To reprocess the shown results [get the images](1getData.sh) from [Test images for Scan Tailor](https://github.com/ImageProcessing-ElectronicPublications/scantailor-testing). [Create](2makeProj.sh) or [use](STprojects/) those ScanTailor projects and [create filtered pictures](3runStCreateFilteredImages.sh) by going to stage 6 in ScanTailor.

One demo project treats all content as an image (A) the other tries to convert text and BW-Images in BW (B). For both A and B a variant uses a scaling factor of one (A1, B1) the other a scaling factor of two (A2, B2). The project consists of 171 pages and the given size is for these 171 pages.

| What | Size | Resolution | Thumb | Text | Letters | Picture | Zoom |
|:-----|-----:|-----------:|:-----:|:----:|:-------:|:-------:|:----:|
| Original | 71'639'885 | ~1660x2450 | ![](images/orig1.jpg) | ![](images/orig2.jpg) | ![](images/orig3.png) | ![](images/orig4.jpg) | ![](images/orig5.jpg) |
| A1 | 1'088'240'912 | 1291x2167 | ![](images/A11.jpg) | ![](images/A12.jpg) | ![](images/A13.png) | ![](images/A14.jpg) | ![](images/A15.jpg) |
| A2 | 4'106'885'020 | 2582x4334 | ![](images/A21.jpg) | ![](images/A22.jpg) | ![](images/A23.png) | ![](images/A24.jpg) | ![](images/A25.jpg) |
| B1 | 35'230'916 | 1291x2167 | ![](images/B11.jpg) | ![](images/B12.png) | ![](images/B13.png) | ![](images/B14.jpg) | ![](images/B15.jpg) |
| B2 | 121'703'962 | 2582x4334 | ![](images/B21.jpg) | ![](images/B22.png) | ![](images/B23.png) | ![](images/B24.jpg) | ![](images/B25.jpg) |

The filtered images could be converted from tif to jpeg and there the quality could be adjusted. Also a conversion to jpeg2000 was done. A pdf could be created with ocrimg2pdfmypdf. mfbpdf could be used to create a (Mask+FG+BG).pdf which could again go throug ocrmypdf. In addition one programm was written which splits an image in black and white and color (splitBWC). The color part could be converted to a JPEG with individual compression settings. The BW part coudl be harmonized using minidjvu-mod and jbig2. Finaly the BW and color pictures are combined to a pdf using img2pdf. splitBWC and img2pdf are in development but are showing a possible way of prepocessing scaned pages.

| What | Size | OCR | Thumb | Text | Letters | Picture | Zoom | Code |
|:-----|-----:|----:|:-----:|:----:|:-------:|:-------:|:----:|:-----|
| A1 | 1'088'240'912 | No | ![](images/A11.jpg) | ![](images/A12.jpg) | ![](images/A13.png) | ![](images/A14.jpg) | ![](images/A15.jpg) | |
| A1=>jpeg | 149'293'752 | No | ![](images/a1Jpg1.jpg) | ![](images/a1Jpg2.jpg) | ![](images/a1Jpg3.png) | ![](images/a1Jpg4.jpg) | ![](images/a1Jpg5.jpg) | [a1Jpg.sh](4postProcess/a1Jpg.sh) |
| A1=>jpeg(q=40) | 45'989'658 | No | ![](images/a1JpgQ401.jpg) | ![](images/a1JpgQ402.jpg) | ![](images/a1JpgQ403.png) | ![](images/a1JpgQ404.jpg) | ![](images/a1JpgQ405.jpg) | [a1JpgQ40.sh](4postProcess/a1JpgQ40.sh) |
| A1=>jp2(q=40) | 63'727'248 | No | ![](images/a1Jp21.jpg) | ![](images/a1Jp22.jpg) | ![](images/a1Jp23.png) | ![](images/a1Jp24.jpg) | ![](images/a1Jp25.jpg) | [a1Jp2.sh](4postProcess/a1Jp2.sh) |
| A1=>ocrmypdf | 51'003'662 | Yes | ![](images/a1Ocr1.jpg) | ![](images/a1Ocr2.jpg) | ![](images/a1Ocr3.png) | ![](images/a1Ocr4.jpg) | ![](images/a1Ocr5.jpg) | [a1Orcmypdf.sh](4postProcess/a1Orcmypdf.sh) |
| A1=>mfbpdf | 19'162'601 | No | ![](images/a1Mfb1.jpg) | ![](images/a1Mfb2.jpg) | ![](images/a1Mfb3.png) | ![](images/a1Mfb4.jpg) | ![](images/a1Mfb5.jpg) | [a1Mfbpdf.sh](4postProcess/a1Mfbpdf.sh) |
| A1=>mfbpdf=>ocrmypdf | 16'220'640 | Yes | ![](images/a1MfbOcr1.jpg) | ![](images/a1MfbOcr2.jpg) | ![](images/a1MfbOcr3.png) | ![](images/a1MfbOcr4.jpg) | ![](images/a1MfbOcr5.jpg) | [a1MfbpdfOcr.sh](4postProcess/a1MfbpdfOcr.sh) |
| | | | | | | | | |
| A2 | 4'106'885'020 | No | ![](images/A21.jpg) | ![](images/A22.jpg) | ![](images/A23.png) | ![](images/A24.jpg) | ![](images/A25.jpg) | |
| A2=>jpeg | 407'846'357 | No | ![](images/a2Jpg1.jpg) | ![](images/a2Jpg2.jpg) | ![](images/a2Jpg3.png) | ![](images/a2Jpg4.jpg) | ![](images/a2Jpg5.jpg) | [a2Jpg.sh](4postProcess/a2Jpg.sh) |
| A2=>jpeg(q=40) | 115'767'060 | No | ![](images/a2JpgQ401.jpg) | ![](images/a2JpgQ402.jpg) | ![](images/a2JpgQ403.png) | ![](images/a2JpgQ404.jpg) | ![](images/a2JpgQ405.jpg) | [a2JpgQ40.sh](4postProcess/a2JpgQ40.sh) |
| A1=>jp2(q=40) | 85'485'002 | No | ![](images/a2Jp21.jpg) | ![](images/a2Jp22.jpg) | ![](images/a2Jp23.png) | ![](images/a2Jp24.jpg) | ![](images/a2Jp25.jpg) | [a2Jp2.sh](4postProcess/a2Jp2.sh) |
| A2=>ocrmypdf | 127'272'512 | Yes | ![](images/a2Ocr1.jpg) | ![](images/a2Ocr2.jpg) | ![](images/a2Ocr3.png) | ![](images/a2Ocr4.jpg) | ![](images/a2Ocr5.jpg) | [a2Orcmypdf.sh](4postProcess/a2Orcmypdf.sh) |
| A2=>mfbpdf | 61'146'148 | No | ![](images/a2Mfb1.jpg) | ![](images/a2Mfb2.jpg) | ![](images/a2Mfb3.png) | ![](images/a2Mfb4.jpg) | ![](images/a2Mfb5.jpg) | [a2Mfbpdf.sh](4postProcess/a2Mfbpdf.sh) |
| A2=>mfbpdf=>ocrmypdf | 48'835'245 | Yes | ![](images/a2MfbOcr1.jpg) | ![](images/a2MfbOcr2.jpg) | ![](images/a2MfbOcr3.png) | ![](images/a2MfbOcr4.jpg) | ![](images/a2MfbOcr5.jpg) | [a2MfbpdfOcr.sh](4postProcess/a2MfbpdfOcr.sh) |
| | | | | | | | | |
| B1 | 35'230'916 | No | ![](images/B11.jpg) | ![](images/B12.png) | ![](images/B13.png) | ![](images/B14.jpg) | ![](images/B15.jpg) | |
| B1=>ocrmypdf | 8'680'026 | Yes | ![](images/b1Ocr1.jpg) | ![](images/b1Ocr2.png) | ![](images/b1Ocr3.png) | ![](images/b1Ocr4.jpg) | ![](images/b1Ocr5.jpg) | [b1Orcmypdf.sh](4postProcess/b1Orcmypdf.sh) |
| B1=>mfbpdf | 7'467'788 | No | ![](images/b1Mfb1.jpg) | ![](images/b1Mfb2.png) | ![](images/b1Mfb3.png) | ![](images/b1Mfb4.jpg) | ![](images/b1Mfb5.jpg) | [b1Mfbpdf.sh](4postProcess/b1Mfbpdf.sh) |
| B1=>mfbpdf=>ocrmypdf | 6'290'884 | Yes | ![](images/b1MfbOcr1.jpg) | ![](images/b1MfbOcr2.png) | ![](images/b1MfbOcr3.png) | ![](images/b1MfbOcr4.jpg) | ![](images/b1MfbOcr5.jpg) | [b1MfbpdfOcr.sh](4postProcess/b1MfbpdfOcr.sh) |
| B1=>split=>harmonize=><br>compress=>combine| 2'719'546 | No | ![](images/b1Split1.jpg) | ![](images/b1Split2.png) | ![](images/b1Split3.png) | ![](images/b1Split4.jpg) | ![](images/b1Split5.jpg) | [b1Split.sh](4postProcess/b1SplitDjvuJbig2Img.sh) |
| B1=>split=>harmonize=><br>compress=>combine=>ocr| 3'933'190 | Yes | ![](images/b1SplitOcr1.jpg) | ![](images/b1SplitOcr2.png) | ![](images/b1SplitOcr3.png) | ![](images/b1SplitOcr4.jpg) | ![](images/b1SplitOcr5.jpg) | [b1SplitOcr.sh](4postProcess/b1SplitDjvuJbig2ImgOcr.sh) |
| B1=>split=>compress=><br>combine| 2'954'851 | No | ![](images/b1SplitB1.jpg) | ![](images/b1SplitB2.png) | ![](images/b1SplitB3.png) | ![](images/b1SplitB4.jpg) | ![](images/b1SplitB5.jpg) | [b1SplitB.sh](4postProcess/b1SplitJbig2Img.sh) |
| B1=>split=>compress=><br>combine=>OCR| 4'159'321 | Yes | ![](images/b1SplitBOcr1.jpg) | ![](images/b1SplitBOcr2.png) | ![](images/b1SplitBOcr3.png) | ![](images/b1SplitBOcr4.jpg) | ![](images/b1SplitBOcr5.jpg) | [b1SplitBOcr.sh](4postProcess/b1SplitJbig2ImgOcr.sh) |
| | | | | | | | | |
| B2 | 121'703'962 | No | ![](images/B21.jpg) | ![](images/B22.png) | ![](images/B23.png) | ![](images/B24.jpg) | ![](images/B25.jpg) | |
| B2=>ocrmypdf | 17'932'000 | Yes | ![](images/b2Ocr1.jpg) | ![](images/b2Ocr2.png) | ![](images/b2Ocr3.png) | ![](images/b2Ocr4.jpg) | ![](images/b2Ocr5.jpg) | [b2Orcmypdf.sh](4postProcess/b2Orcmypdf.sh) |
| B2=>mfbpdf | 16'086'247 | No | ![](images/b2Mfb1.jpg) | ![](images/b2Mfb2.png) | ![](images/b2Mfb3.png) | ![](images/b2Mfb4.jpg) | ![](images/b2Mfb5.jpg) | [b2Mfbpdf.sh](4postProcess/b2Mfbpdf.sh) |
| B2=>mfbpdf=>ocrmypdf | 11'755'367 | Yes | ![](images/b2MfbOcr1.jpg) | ![](images/b2MfbOcr2.png) | ![](images/b2MfbOcr3.png) | ![](images/b2MfbOcr4.jpg) | ![](images/b2MfbOcr5.jpg) | [b2MfbpdfOcr.sh](4postProcess/b2MfbpdfOcr.sh) |
| B2=>split=>harmonize=><br>compress=>combine| 3'625'202 | No | ![](images/b2Split1.jpg) | ![](images/b2Split2.png) | ![](images/b2Split3.png) | ![](images/b2Split4.jpg) | ![](images/b2Split5.jpg) | [b2Split.sh](4postProcess/b2SplitDjvuJbig2Img.sh) |
| B2=>split=>harmonize=><br>compress=>combine=>Ocr| 4'871'032 | Yes | ![](images/b2SplitOcr1.jpg) | ![](images/b2SplitOcr2.png) | ![](images/b2SplitOcr3.png) | ![](images/b2SplitOcr4.jpg) | ![](images/b2SplitOcr5.jpg) | [b2SplitOcr.sh](4postProcess/b2SplitDjvuJbig2ImgOcr.sh) |
| B2=>split=>compress=><br>combine| 4'159'321 | No | ![](images/b2SplitB1.jpg) | ![](images/b2SplitB2.png) | ![](images/b2SplitB3.png) | ![](images/b2SplitB4.jpg) | ![](images/b2SplitB5.jpg) | [b2SplitB.sh](4postProcess/b2SplitDjvuJbig2Img.sh) |
| B2=>split=>compress=><br>combine=>Ocr| 5'304'178 | Yes | ![](images/b2SplitBOcr1.jpg) | ![](images/b2SplitBOcr2.png) | ![](images/b2SplitBOcr3.png) | ![](images/b2SplitBOcr4.jpg) | ![](images/b2SplitBOcr5.jpg) | [b2SplitBOcr.sh](4postProcess/b2SplitDjvuJbig2ImgOcr.sh) |

---
In case the scaned project consists only of *black and white* pages:  
Go to the folder of the output images which have been proccessed with ScanTailor (out) and convert them to JBIG2.
```
jbig2 -p -s -t .85 -a -w .1 *.tif
```
where `-p` produces PDF ready data, `-s` is the symbole mode for texts, `-t` sets the classification threshold for symbol coder (tool low values could lead to character substitution errors. E.g. a 1 gets an I. Default is .92), `-a` uses automatic thresholding in symbol encoder and `-w` sets the classification weight for symbol coder (def: 0.5).  
This will create files named `output.` followed by a 5 digit number and one called `output.sym`. The name coudld be changed with `-b`  
And create a pdf with:
```
jbig2topdf.py output > out.pdf
```
An optical character recognition (OCR) could be done with:
```
pipx run ocrmypdf -l rus --jobs 7 --output-type pdf out.pdf ocr.pdf
```
Where `-l` sets the language to use (rus..Russian, eng..Englisch, deu..German, frk..German-Fraktur, deu+eng..German and English), `--jobs` sets the number of cores to use, `--output-type pdf` keep the pdf as it is.  
[JBIG2](https://github.com/agl/jbig2enc) and [ocrmypdf](https://ocrmypdf.readthedocs.io/en/latest/index.html) are used.

---
In case the scaned project consists of *black and white* and also *gray or color* parts:  
Go to the folder of the output images which have been proccessed with ScanTailor (out) and split the pages in BW and color with:
```
for fn in *.tif; do splitBWC $fn; done
```
This creates the folders `bw` and `c` and places there the black and white and gray/color page parts.  
The gray/color images need to be converted to JPEG:
```
mogrify -path ./c -format jpg -quality 20 -resize 50% ./c/*.tif
```
where `-quality` sets the compression quality (100 is highest quality) and `-resize` could be used to change the resolution of the image.  
The black and white images need to be converted to JBIG2:
```
mkdir j
jbig2 -b ./j/jb2 -p -s -t .85 -a -w .1 ./bw/*.tif
```
where `-b` sets the path and name of the resulting files, `-p` produces PDF ready data, `-s` is the symbole mode for texts, `-t` sets the classification threshold for symbol coder (tool low values could lead to character substitution errors. E.g. a 1 gets an I. Default is .92), `-a` uses automatic thresholding in symbol encoder and `-w` sets the classification weight for symbol coder (def: 0.5).  
Those pictures could be arranged to a pdf with:
```
img2pdf .24 ./j/jb2 *.tif > out.pdf
```
where the first number (here `.24`) gives the Userunit what defines the resolution (72/0.24 = 300dpi), the second argument (`./j/jb2`) gives the folder there the jbig2 images could be found, the third argument (`*.tif`) gives the names of the original images which are used to find the color images.  
An optical character recognition (OCR) could be done with:
```
pipx run ocrmypdf -l rus --jobs 7 --output-type pdf out.pdf ocr.pdf
```
Where `-l` sets the language to use (rus..Russian, eng..English, deu..German, frk..German-Fraktur, deu+eng..German and English), `--jobs` sets the number of cores to use, `--output-type pdf` keep the pdf as it is.  

[ImageMagick - mogrify](https://imagemagick.org), [JBIG2](https://github.com/agl/jbig2enc) and [ocrmypdf](https://ocrmypdf.readthedocs.io/en/latest/index.html) are used.
In addition `splitBWC` and `img2pdf`, which can be found at [src](https://github.com/GeorgKindermann/ScanTailorPostProcess/tree/main/src) are used. If `libtiff` is installed they could be compiled with `make`. The resulting binaries could be copied to `~/.local/bin` or `/usr/local/bin`.

---
I found it sometimes usefull to increase the (automatically) selected content by some pixels using [xmlstarlet](https://xmlstar.sourceforge.net/) (here for the ScanTailor project file `st.ScanTailor`)
```
#Increase Content by D pixel in each diretion
P0=/project/filters/select-content/page/params
P=$P0/content-box
D=2
xmlstarlet ed -u "$P0[@mode=\"auto\"]/@mode" -v manual st.ScanTailor |
    xmlstarlet ed -u "$P/top/@y" -x .-$D |
    xmlstarlet ed -u "$P/bottom/@y" -x .+$D |
    xmlstarlet ed -u "$P/left/@x" -x .-$D |
    xmlstarlet ed -u "$P/right/@x" -x .+$D |
    tail +2 > st2.ScanTailor
```
and trim the result afterwards with:
```
mogrify -trim *.tif
```

---
Converting the resulting pdf back to somthing simmilar like the original tifs (the compressions are not lossless) using [pdftoppm](https://github.com/justmoon/poppler-http/tree/master):
```
mkdir tif
pdftoppm -r 72 -tiff -tiffcompression deflate out.pdf ./tif/p
```
