#use mfbpdf
mkdir /tmp/st/a2Mfb
for PFE in /tmp/st/outA2/*.tif
do
  FE=${PFE##*/}
  F=${FE%.tif}
  echo $F
  tifftopnm $PFE >/tmp/st/a2Mfb/${F}.pnm
  mfbpdf /tmp/st/a2Mfb/${F}.pnm /tmp/st/a2Mfb/${F}.tif /tmp/st/a2Mfb/${F}.pdf
  rm /tmp/st/a2Mfb/${F}.pnm /tmp/st/a2Mfb/${F}.tif
done
pdfunite /tmp/st/a2Mfb/*.pdf /tmp/st/a2Mfb.pdf # 61146148
pipx run ocrmypdf -l rus --jobs 7 --output-type pdfa --pdfa-image-compression jpeg --jbig2-lossy --optimize 3 /tmp/st/a2Mfb.pdf /tmp/st/a2MfbOcr.pdf # 48835245


#Extract sample pictures
pdftoppm -f 149 -l 149 -r 300 -png /tmp/st/a2MfbOcr.pdf /tmp/st/a2MfbOcrC
convert -resize x200 /tmp/st/a2MfbOcrC-149.png ../images/a2MfbOcr1.jpg
convert -crop 520x520+130+3240 -resize x200 /tmp/st/a2MfbOcrC-149.png ../images/a2MfbOcr2.jpg
convert -crop 86x50+330+3530 -sample x200 /tmp/st/a2MfbOcrC-149.png ../images/a2MfbOcr3.png
convert -crop 1968x1666+290+992 -resize x200 /tmp/st/a2MfbOcrC-149.png ../images/a2MfbOcr4.jpg
convert -crop 200x200+620+1270 -sample x200 /tmp/st/a2MfbOcrC-149.png ../images/a2MfbOcr5.jpg
