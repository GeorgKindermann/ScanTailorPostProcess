# use splitBWC
mkdir /tmp/st/b1Split
cp /tmp/st/outB1/*.tif /tmp/st/b1Split
# Remove white Borders
mogrify -trim /tmp/st/b1Split/*.tif
# Split the image in Black White and Color
for fn in /tmp/st/b1Split/*.tif; do splitBWC $fn; done
# Recompress Color Pictures as JPEG
mogrify -path /tmp/st/b1Split/c/ -format jpg /tmp/st/b1Split/c/*.tif
# Convert to c44
for fn in /tmp/st/b1Split/c/*.jpg; do c44 $fn; done
# Make djvu
cd /tmp/st/b1Split
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
pipx run ocrodjvu -e tesseract -l rus -j 7 -o /tmp/st/b1Split/ocr.djvu /tmp/st/b1Split/out.djvu



#Extract sample pictures
ddjvu -format=tiff -page=149 /tmp/st/b1Split/ocr.djvu /tmp/page.tif
convert -resize x200 /tmp/page.tif ../images/b1DjvuOcr1.jpg
convert -crop 260x260+65+1620 -resize x200 /tmp/page.tif ../images/b1DjvuOcr2.png
convert -crop 43x25+165+1765 -sample x200 /tmp/page.tif ../images/b1DjvuOcr3.png
convert -crop 984x833+145+496 -resize x200 /tmp/page.tif ../images/b1DjvuOcr4.jpg
convert -crop 100x100+310+635 -sample x200 /tmp/page.tif ../images/b1DjvuOcr5.jpg
