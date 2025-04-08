#Orignal pictures
convert -crop 1660x2450+1595+0 -resize x200 /tmp/st/pic/page-076.jpg orig1.jpg
convert -crop 309x321+1773+1722 -resize x200 /tmp/st/pic/page-076.jpg orig2.jpg
convert -crop 52x30+1900+1894 -sample x200 /tmp/st/pic/page-076.jpg orig3.png
convert -crop 1130x867+1790+560 -resize x200 /tmp/st/pic/page-076.jpg orig4.jpg
convert -crop 100x100+1990+705 -sample x200 /tmp/st/pic/page-076.jpg orig5.jpg

#Outputs from ScanTailor
convert -resize x200 /tmp/st/outA1/page-076_2R.tif A11.jpg
convert -crop 260x260+65+1620 -resize x200 /tmp/st/outA1/page-076_2R.tif A12.jpg
convert -crop 43x25+165+1765 -sample x200 /tmp/st/outA1/page-076_2R.tif A13.png
convert -crop 984x833+145+496 -resize x200 /tmp/st/outA1/page-076_2R.tif A14.jpg
convert -crop 100x100+310+635 -sample x200 /tmp/st/outA1/page-076_2R.tif A15.jpg
#
convert -resize x200 /tmp/st/outA2/page-076_2R.tif A21.jpg
convert -crop 520x520+130+3240 -resize x200 /tmp/st/outA2/page-076_2R.tif A22.jpg
convert -crop 86x50+330+3530 -sample x200 /tmp/st/outA2/page-076_2R.tif A23.png
convert -crop 1968x1666+290+992 -resize x200 /tmp/st/outA2/page-076_2R.tif A24.jpg
convert -crop 200x200+620+1270 -sample x200 /tmp/st/outA2/page-076_2R.tif A25.jpg
#
convert -resize x200 /tmp/st/outB1/page-076_2R.tif B11.jpg
convert -crop 260x260+65+1620 -resize x200 /tmp/st/outB1/page-076_2R.tif B12.png
convert -crop 43x25+165+1765 -sample x200 /tmp/st/outB1/page-076_2R.tif B13.png
convert -crop 984x833+145+496 -resize x200 /tmp/st/outB1/page-076_2R.tif B14.jpg
convert -crop 100x100+310+635 -sample x200 /tmp/st/outB1/page-076_2R.tif B15.jpg
#
convert -resize x200 /tmp/st/outB2/page-076_2R.tif B21.jpg
convert -crop 520x520+130+3240 -resize x200 /tmp/st/outB2/page-076_2R.tif B22.png
convert -crop 86x50+330+3530 -sample x200 /tmp/st/outB2/page-076_2R.tif B23.png
convert -crop 1968x1666+290+992 -resize x200 /tmp/st/outB2/page-076_2R.tif B24.jpg
convert -crop 200x200+620+1270 -sample x200 /tmp/st/outB2/page-076_2R.tif B25.jpg
