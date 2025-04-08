# use splitBWC
mkdir /tmp/st/b1Split
cp /tmp/st/outB1/*.tif /tmp/st/b1Split
# Remove white Borders
mogrify -trim /tmp/st/b1Split/*.tif
# Split the image in Black White and Color
for fn in /tmp/st/b1Split/*.tif; do ./splitBWC $fn; done
# Recompress Color Pictures as JPEG
mogrify -path /tmp/st/b1Split/c/ -format jpg -quality 20 -resize 50% /tmp/st/b1Split/c/*.tif
# Harmonize Black White - High compression can lead to wrong character substitution
mkdir /tmp/st/b1Split/dj
minidjvu-mod -l -a 15 /tmp/st/b1Split/bw/*.tif /tmp/st/b1Split/dj/book.djvu
# Convert djvu to tif
ddjvu -format=tiff /tmp/st/b1Split/dj/book.djvu /tmp/st/b1Split/dj/book.tif
# Make singel tif pages
mkdir /tmp/st/b1Split/t
tiffsplit /tmp/st/b1Split/dj/book.tif /tmp/st/b1Split/t/
# Convert Black White to jbig2
mkdir /tmp/st/b1Split/j
jbig2 -b /tmp/st/b1Split/j/jb2 -p -s -t .85 -a -w .1 /tmp/st/b1Split/t/*.tif
# Combine pictures to pdf
./img2pdf /tmp/st/b1Split/j/jb2 /tmp/st/b1Split/*.tif
#make ocr
pipx run ocrmypdf -l rus --jobs 7 --output-type pdf /tmp/pdfx.pdf /tmp/st/b1SplotOcr.pdf #


#Extract sample pictures
convert -density 72 -background white -alpha remove -alpha off /tmp/st/b1SplotOcr.pdf[148] /tmp/st/b1SplitOcr-149.png
convert -resize x200 /tmp/st/b1SplitOcr-149.png ../images/b1SplitOcr1.jpg
convert -crop 260x260+65+1620 -resize x200 /tmp/st/b1SplitOcr-149.png ../images/b1SplitOcr2.png
convert -crop 43x25+165+1765 -sample x200 /tmp/st/b1SplitOcr-149.png ../images/b1SplitOcr3.png
convert -crop 984x833+145+496 -resize x200 /tmp/st/b1SplitOcr-149.png ../images/b1SplitOcr4.jpg
convert -crop 100x100+310+635 -sample x200 /tmp/st/b1SplitOcr-149.png ../images/b1SplitOcr5.jpg
