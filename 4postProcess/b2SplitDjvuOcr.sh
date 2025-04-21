# use splitBWC
mkdir /tmp/st/b2Split
cp /tmp/st/outB2/*.tif /tmp/st/b2Split
# Remove white Borders
mogrify -trim /tmp/st/b2Split/*.tif
# Split the image in Black White and Color
for fn in /tmp/st/b2Split/*.tif; do splitBWC $fn; done
# Recompress Color Pictures as JPEG
mogrify -path /tmp/st/b2Split/c/ -format jpg /tmp/st/b2Split/c/*.tif
# Convert to c44
for fn in /tmp/st/b2Split/c/*.jpg; do c44 $fn; done
# Make djvu
cd /tmp/st/b2Split
minidjvu -i ./bw/*.tif index.djvu
# Include Colour Pictures
for fn in ./c/*.djvu
do
    s=${fn##*/}
    s=${s%.djvu}
    echo $s
    djvuextract $fn BG44=bg44.bg44
    djvuextract $s.djvu INCL=incl.txt Sjbz=sjbz.sjbz
    djvumake $s.djvu INCL=$(< incl.txt) Sjbz=sjbz.sjbz BG44=bg44.bg44
done
# Create one file
djvm -c out.djvu index.djvu
# Make OCR
pipx run ocrodjvu -e tesseract -l rus -j 7 -o /tmp/st/b2Split/ocr.djvu /tmp/st/b2Split/out.djvu



#Extract sample pictures
ddjvu -format=tiff -page=149 /tmp/st/b2Split/ocr.djvu /tmp/page.tif
convert -resize x200 /tmp/page.tif ../images/b2DjvuOcr1.jpg
convert -crop 520x520+130+3240 -resize x200 /tmp/page.tif ../images/b2DjvuOcr2.png
convert -crop 86x50+330+3530 -sample x200 /tmp/page.tif ../images/b2DjvuOcr3.png
convert -crop 1968x1666+290+992 -resize x200 /tmp/page.tif ../images/b2DjvuOcr4.jpg
convert -crop 200x200+620+1270 -sample x200 /tmp/page.tif ../images/b2DjvuOcr5.jpg
