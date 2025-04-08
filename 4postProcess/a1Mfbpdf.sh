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


#Extract sample pictures
pdftoppm -f 149 -l 149 -r 300 -png /tmp/st/a1Mfb.pdf /tmp/st/a1MfbC
convert -resize x200 /tmp/st/a1MfbC-149.png ../images/a1Mfb1.jpg
convert -crop 260x260+65+1620 -resize x200 /tmp/st/a1MfbC-149.png ../images/a1Mfb2.jpg
convert -crop 43x25+165+1765 -sample x200 /tmp/st/a1MfbC-149.png ../images/a1Mfb3.png
convert -crop 984x833+145+496 -resize x200 /tmp/st/a1MfbC-149.png ../images/a1Mfb4.jpg
convert -crop 100x100+310+635 -sample x200 /tmp/st/a1MfbC-149.png ../images/a1Mfb5.jpg
