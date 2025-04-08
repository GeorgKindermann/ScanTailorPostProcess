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


#Extract sample pictures
pdftoppm -f 149 -l 149 -r 300 -png /tmp/st/a2Mfb.pdf /tmp/st/a2MfbC
convert -resize x200 /tmp/st/a2MfbC-149.png ../images/a2Mfb1.jpg
convert -crop 520x520+130+3240 -resize x200 /tmp/st/a2MfbC-149.png ../images/a2Mfb2.jpg
convert -crop 86x50+330+3530 -sample x200 /tmp/st/a2MfbC-149.png ../images/a2Mfb3.png
convert -crop 1968x1666+290+992 -resize x200 /tmp/st/a2MfbC-149.png ../images/a2Mfb4.jpg
convert -crop 200x200+620+1270 -sample x200 /tmp/st/a2MfbC-149.png ../images/a2Mfb5.jpg
