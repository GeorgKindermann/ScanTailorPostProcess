#use mfbpdf
mkdir /tmp/st/b2Mfb
for PFE in /tmp/st/outB2/*.tif
do
  FE=${PFE##*/}
  F=${FE%.tif}
  echo $F
  tifftopnm $PFE >/tmp/st/b2Mfb/${F}.pnm
  mfbpdf /tmp/st/b2Mfb/${F}.pnm /tmp/st/b2Mfb/${F}.tif /tmp/st/b2Mfb/${F}.pdf
  rm /tmp/st/b2Mfb/${F}.pnm /tmp/st/b2Mfb/${F}.tif
done
pdfunite /tmp/st/b2Mfb/*.pdf /tmp/st/b2Mfb.pdf # 16086247
#make ocr
pipx run ocrmypdf -l rus --jobs 7 --output-type pdfa --pdfa-image-compression jpeg --jbig2-lossy --optimize 3 /tmp/st/b2Mfb.pdf /tmp/st/b2MfbOcr.pdf # 11755367


#Extract sample pictures
convert -density 300 /tmp/st/b2MfbOcr.pdf[148] /tmp/st/b2MfbOcrC-149.png
convert -resize x200 /tmp/st/b2MfbOcrC-149.png ../images/b2MfbOcr1.jpg
convert -crop 520x520+130+3240 -resize x200 /tmp/st/b2MfbOcrC-149.png ../images/b2MfbOcr2.png
convert -crop 86x50+330+3530 -sample x200 /tmp/st/b2MfbOcrC-149.png ../images/b2MfbOcr3.png
convert -crop 1968x1666+290+992 -resize x200 /tmp/st/b2MfbOcrC-149.png ../images/b2MfbOcr4.jpg
convert -crop 200x200+620+1270 -sample x200 /tmp/st/b2MfbOcrC-149.png ../images/b2MfbOcr5.jpg
