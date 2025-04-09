# use splitBWC
mkdir /tmp/st/b1Split
cp /tmp/st/outB1/*.tif /tmp/st/b1Split
# Remove white Borders
mogrify -trim /tmp/st/b1Split/*.tif
# Split the image in Black White and Color
for fn in /tmp/st/b1Split/*.tif; do ./splitBWC $fn; done
# Recompress Color Pictures as JPEG
mogrify -path /tmp/st/b1Split/c/ -format jpg -quality 20 -resize 50% /tmp/st/b1Split/c/*.tif
# Convert Black White to jbig2
mkdir /tmp/st/b1Split/j
jbig2 -b /tmp/st/b1Split/j/jb2 -p -s -t .85 -a -w .1 /tmp/st/b1Split/bw/*.tif
# Combine pictures to pdf
./img2pdf .24 /tmp/st/b1Split/j/jb2 /tmp/st/b1Split/*.tif


#Extract sample pictures
convert -density 300 -background white -alpha remove -alpha off /tmp/pdfx.pdf[148] /tmp/st/b1Split-149.png
convert -resize x200 /tmp/st/b1Split-149.png ../images/b1SplitB1.jpg
convert -crop 260x260+65+1620 -resize x200 /tmp/st/b1Split-149.png ../images/b1SplitB2.png
convert -crop 43x25+165+1765 -sample x200 /tmp/st/b1Split-149.png ../images/b1SplitB3.png
convert -crop 984x833+145+496 -resize x200 /tmp/st/b1Split-149.png ../images/b1SplitB4.jpg
convert -crop 100x100+310+635 -sample x200 /tmp/st/b1Split-149.png ../images/b1SplitB5.jpg
