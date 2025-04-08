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


#Extract sample pictures
convert -density 300 /tmp/st/b2Mfb.pdf[148] /tmp/st/b2MfbC-149.png
convert -resize x200 /tmp/st/b2MfbC-149.png ../images/b2Mfb1.jpg
convert -crop 520x520+130+3240 -resize x200 /tmp/st/b2MfbC-149.png ../images/b2Mfb2.png
convert -crop 86x50+330+3530 -sample x200 /tmp/st/b2MfbC-149.png ../images/b2Mfb3.png
convert -crop 1968x1666+290+992 -resize x200 /tmp/st/b2MfbC-149.png ../images/b2Mfb4.jpg
convert -crop 200x200+620+1270 -sample x200 /tmp/st/b2MfbC-149.png ../images/b2Mfb5.jpg
