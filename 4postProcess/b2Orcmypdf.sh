#make one tiff
tiffcp /tmp/st/outB2/*.tif /tmp/st/b2.tif # 12816072
#Convert the tiff to a pdf
tiff2pdf -o /tmp/st/b2.pdf /tmp/st/b2.tif # 355573919
#add ocr and compress pdf
pipx run ocrmypdf -l rus --jobs 7 --output-type pdfa --pdfa-image-compression jpeg --jbig2-lossy --optimize 3 /tmp/st/b2.pdf /tmp/st/b2Ocr.pdf # 17932000


#Extract sample pictures
pdfimages -f 149 -l 149 -png /tmp/st/b2Ocr.pdf /tmp/st/b2OcrC
convert -resize x200 /tmp/st/b2OcrC-000.png ../images/b2Ocr1.jpg
convert -crop 520x520+130+3240 -resize x200 /tmp/st/b2OcrC-000.png ../images/b2Ocr2.png
convert -crop 86x50+330+3530 -sample x200 /tmp/st/b2OcrC-000.png ../images/b2Ocr3.png
convert -crop 1968x1666+290+992 -resize x200 /tmp/st/b2OcrC-000.png ../images/b2Ocr4.jpg
convert -crop 200x200+620+1270 -sample x200 /tmp/st/b2OcrC-000.png ../images/b2Ocr5.jpg
