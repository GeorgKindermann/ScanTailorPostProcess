#use mfbpdf
mkdir /tmp/st/b1Mfb
for PFE in /tmp/st/outB1/*.tif
do
  FE=${PFE##*/}
  F=${FE%.tif}
  echo $F
  tifftopnm $PFE >/tmp/st/b1Mfb/${F}.pnm
  mfbpdf /tmp/st/b1Mfb/${F}.pnm /tmp/st/b1Mfb/${F}.tif /tmp/st/b1Mfb/${F}.pdf
  rm /tmp/st/b1Mfb/${F}.pnm /tmp/st/b1Mfb/${F}.tif
done
pdfunite /tmp/st/b1Mfb/*.pdf /tmp/st/b1Mfb.pdf # 7467788


#Extract sample pictures
convert -density 300 /tmp/st/b1Mfb.pdf[148] /tmp/st/b1MfbC-149.png
convert -resize x200 /tmp/st/b1MfbC-149.png ../images/b1Mfb1.jpg
convert -crop 260x260+65+1620 -resize x200 /tmp/st/b1MfbC-149.png ../images/b1Mfb2.png
convert -crop 43x25+165+1765 -sample x200 /tmp/st/b1MfbC-149.png ../images/b1Mfb3.png
convert -crop 984x833+145+496 -resize x200 /tmp/st/b1MfbC-149.png ../images/b1Mfb4.jpg
convert -crop 100x100+310+635 -sample x200 /tmp/st/b1MfbC-149.png ../images/b1Mfb5.jpg
