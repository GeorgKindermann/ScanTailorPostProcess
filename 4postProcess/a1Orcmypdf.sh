#make one tiff
tiffcp /tmp/st/outA1/*.tif /tmp/st/a1.tif # 1155193166
#Convert the tiff to a pdf
tiff2pdf -o /tmp/st/a1.pdf /tmp/st/a1.tif # 1510475648
#add ocr and compress pdf
pipx run ocrmypdf -l rus --jobs 7 --output-type pdfa --pdfa-image-compression jpeg --jbig2-lossy --optimize 3 /tmp/st/a1.pdf /tmp/st/a1Ocr.pdf # 51003662


#Extract sample pictures
pdfimages -f 149 -l 149 -png /tmp/st/a1Ocr.pdf /tmp/st/a1OcrC
convert -resize x200 /tmp/st/a1OcrC-000.png ../images/a1Ocr1.jpg
convert -crop 260x260+65+1620 -resize x200 /tmp/st/a1OcrC-000.png ../images/a1Ocr2.jpg
convert -crop 43x25+165+1765 -sample x200 /tmp/st/a1OcrC-000.png ../images/a1Ocr3.png
convert -crop 984x833+145+496 -resize x200 /tmp/st/a1OcrC-000.png ../images/a1Ocr4.jpg
convert -crop 100x100+310+635 -sample x200 /tmp/st/a1OcrC-000.png ../images/a1Ocr5.jpg
