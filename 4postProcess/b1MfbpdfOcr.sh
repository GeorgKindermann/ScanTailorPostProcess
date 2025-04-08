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
#make ocr
pipx run ocrmypdf -l rus --jobs 7 --output-type pdfa --pdfa-image-compression jpeg --jbig2-lossy --optimize 3 /tmp/st/b1Mfb.pdf /tmp/st/b1MfbOcr.pdf # 6290884


#Extract sample pictures
convert -density 300 /tmp/st/b1MfbOcr.pdf[148] /tmp/st/b1MfbOcrC-149.png
convert -resize x200 /tmp/st/b1MfbOcrC-149.png ../images/b1MfbOcr1.jpg
convert -crop 260x260+65+1620 -resize x200 /tmp/st/b1MfbOcrC-149.png ../images/b1MfbOcr2.png
convert -crop 43x25+165+1765 -sample x200 /tmp/st/b1MfbOcrC-149.png ../images/b1MfbOcr3.png
convert -crop 984x833+145+496 -resize x200 /tmp/st/b1MfbOcrC-149.png ../images/b1MfbOcr4.jpg
convert -crop 100x100+310+635 -sample x200 /tmp/st/b1MfbOcrC-149.png ../images/b1MfbOcr5.jpg
