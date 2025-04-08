#use mfbpdf
mkdir /tmp/st/a1Mfb
for PFE in /tmp/st/outA1/*.tif
do
  FE=${PFE##*/}
  F=${FE%.tif}
  echo $F
  tifftopnm $PFE >/tmp/st/a1Mfb/${F}.pnm
  mfbpdf /tmp/st/a1Mfb/${F}.pnm /tmp/st/a1Mfb/${F}.tif /tmp/st/a1Mfb/${F}.pdf
  rm /tmp/st/a1Mfb/${F}.pnm /tmp/st/a1Mfb/${F}.tif
done
pdfunite /tmp/st/a1Mfb/*.pdf /tmp/st/a1Mfb.pdf # 19162601
#make ocr
pipx run ocrmypdf -l rus --jobs 7 --output-type pdfa --pdfa-image-compression jpeg --jbig2-lossy --optimize 3 /tmp/st/a1Mfb.pdf /tmp/st/a1MfbOcr.pdf # 16220640


#Extract sample pictures
pdftoppm -f 149 -l 149 -r 300 -png /tmp/st/a1MfbOcr.pdf /tmp/st/a1MfbOcrC
convert -resize x200 /tmp/st/a1MfbOcrC-149.png ../images/a1MfbOcr1.jpg
convert -crop 260x260+65+1620 -resize x200 /tmp/st/a1MfbOcrC-149.png ../images/a1MfbOcr2.jpg
convert -crop 43x25+165+1765 -sample x200 /tmp/st/a1MfbOcrC-149.png ../images/a1MfbOcr3.png
convert -crop 984x833+145+496 -resize x200 /tmp/st/a1MfbOcrC-149.png ../images/a1MfbOcr4.jpg
convert -crop 100x100+310+635 -sample x200 /tmp/st/a1MfbOcrC-149.png ../images/a1MfbOcr5.jpg
