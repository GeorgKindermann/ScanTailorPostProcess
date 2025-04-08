#make one tiff
tiffcp /tmp/st/outA2/*.tif /tmp/st/a2.tif # 4176534948
#Convert the tiff to a pdf
tiff2pdf -o /tmp/st/a2.pdf /tmp/st/a2.tif # 6041500617
#add ocr and compress pdf
pipx run ocrmypdf -l rus --jobs 7 --output-type pdfa --pdfa-image-compression jpeg --jbig2-lossy --optimize 3 /tmp/st/a2.pdf /tmp/st/a2Ocr.pdf # 127272512


#Extract sample pictures
pdfimages -f 149 -l 149 -png /tmp/st/a2Ocr.pdf /tmp/st/a2OcrC
convert -resize x200 /tmp/st/a2OcrC-000.png ../images/a2Ocr1.jpg
convert -crop 520x520+130+3240 -resize x200 /tmp/st/a2OcrC-000.png ../images/a2Ocr2.jpg
convert -crop 86x50+330+3530 -sample x200 /tmp/st/a2OcrC-000.png ../images/a2Ocr3.png
convert -crop 1968x1666+290+992 -resize x200 /tmp/st/a2OcrC-000.png ../images/a2Ocr4.jpg
convert -crop 200x200+620+1270 -sample x200 /tmp/st/a2OcrC-000.png ../images/a2Ocr5.jpg
