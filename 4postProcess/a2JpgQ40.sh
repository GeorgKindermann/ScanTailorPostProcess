#Convert the filtered images to jpg
mkdir /tmp/st/a2JpgQ40
mogrify -path /tmp/st/a2JpgQ40 -format jpg -quality 40 /tmp/st/outA2/*.tif


#Get Size
du -bc /tmp/st/a2JpgQ40/*.jpg #size: 115767060

#Extract sample pictures
convert -resize x200 /tmp/st/a2JpgQ40/page-076_2R.jpg ../images/a2JpgQ401.jpg
convert -crop 520x520+130+3240 -resize x200 /tmp/st/a2JpgQ40/page-076_2R.jpg ../images/a2JpgQ402.jpg
convert -crop 86x50+330+3530 -sample x200 /tmp/st/a2JpgQ40/page-076_2R.jpg ../images/a2JpgQ403.png
convert -crop 1968x1666+290+992 -resize x200 /tmp/st/a2JpgQ40/page-076_2R.jpg ../images/a2JpgQ404.jpg
convert -crop 200x200+620+1270 -sample x200 /tmp/st/a2JpgQ40/page-076_2R.jpg ../images/a2JpgQ405.jpg
