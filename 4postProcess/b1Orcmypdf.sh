#make one tiff
tiffcp /tmp/st/outB1/*.tif /tmp/st/b1.tif # 38095682
#Convert the tiff to a pdf
tiff2pdf -o /tmp/st/b1.pdf /tmp/st/b1.tif # 91906879
#add ocr and compress pdf
pipx run ocrmypdf -l rus --jobs 7 --output-type pdfa --pdfa-image-compression jpeg --jbig2-lossy --optimize 3 /tmp/st/b1.pdf /tmp/st/b1Ocr.pdf # 8680026


#Extract sample pictures
pdfimages -f 149 -l 149 -png /tmp/st/b1Ocr.pdf /tmp/st/b1OcrC
convert -resize x200 /tmp/st/b1OcrC-000.png ../images/b1Ocr1.jpg
convert -crop 260x260+65+1620 -resize x200 /tmp/st/b1OcrC-000.png ../images/b1Ocr2.png
convert -crop 43x25+165+1765 -sample x200 /tmp/st/b1OcrC-000.png ../images/b1Ocr3.png
convert -crop 984x833+145+496 -resize x200 /tmp/st/b1OcrC-000.png ../images/b1Ocr4.jpg
convert -crop 100x100+310+635 -sample x200 /tmp/st/b1OcrC-000.png ../images/b1Ocr5.jpg
