# use splitBWC
mkdir /tmp/st/b2Split
cp /tmp/st/outB2/*.tif /tmp/st/b2Split
# Remove white Borders
mogrify -trim /tmp/st/b2Split/*.tif
# Split the image in Black White and Color
for fn in /tmp/st/b2Split/*.tif; do splitBWC $fn; done
for fn in /tmp/st/b2Split/c/*.tif; do subImages $fn 1; done
# Recompress Color Pictures as JPEG
mogrify -path /tmp/st/b2Split/cs/ -format jpg -quality 20 -resize 25% /tmp/st/b2Split/cs/*.tif
# Harmonize Black White - High compression can lead to wrong character substitution
mkdir /tmp/st/b2Split/dj
minidjvu -l -d 600 -a 400 -p 57 -v /tmp/st/b2Split/bw/*.tif /tmp/st/b2Split/dj/book.djvu
# Convert djvu to tif
ddjvu -format=tiff /tmp/st/b2Split/dj/book.djvu /tmp/st/b2Split/dj/book.tif
# Make singel tif pages
mkdir /tmp/st/b2Split/t
tiffsplit /tmp/st/b2Split/dj/book.tif /tmp/st/b2Split/t/
# Convert Black White to jbig2
mkdir /tmp/st/b2Split/j
jbig2 -b /tmp/st/b2Split/j/jb2 -p -s -t .80 -a -w .1 /tmp/st/b2Split/t/*.tif
# Combine pictures to pdf
img2pdf .12 "" /tmp/st/b2Split/j/jb2 /tmp/st/b2Split/*.tif > /tmp/pdfx.pdf
#make ocr
pipx run ocrmypdf -l rus --jobs 7 --output-type pdf /tmp/pdfx.pdf /tmp/st/b2SplotOcr.pdf


#Extract sample pictures
convert -density 600 -background white -alpha remove -alpha off /tmp/pdfx.pdf[148] /tmp/st/b2SplitOcr-149.png
convert -resize x200 /tmp/st/b2SplitOcr-149.png ../images/b2SplitOcr1.jpg
convert -crop 520x520+130+3240 -resize x200 /tmp/st/b2SplitOcr-149.png ../images/b2SplitOcr2.png
convert -crop 86x50+330+3530 -sample x200 /tmp/st/b2SplitOcr-149.png ../images/b2SplitOcr3.png
convert -crop 1968x1666+290+992 -resize x200 /tmp/st/b2SplitOcr-149.png ../images/b2SplitOcr4.jpg
convert -crop 200x200+620+1270 -sample x200 /tmp/st/b2SplitOcr-149.png ../images/b2SplitOcr5.jpg
