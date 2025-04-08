#Convert the filtered images to jpg
mkdir /tmp/st/a1JpgQ40
mogrify -path /tmp/st/a1JpgQ40 -format jpg -quality 40 /tmp/st/outA1/*.tif


#Get Size
du -bc /tmp/st/a1Jpg/*.jpg #size: 149293752

#Extract sample pictures
convert -resize x200 /tmp/st/a1JpgQ40/page-076_2R.jpg ../images/a1JpgQ401.jpg
convert -crop 260x260+65+1620 -resize x200 /tmp/st/a1JpgQ40/page-076_2R.jpg ../images/a1JpgQ402.jpg
convert -crop 43x25+165+1765 -sample x200 /tmp/st/a1JpgQ40/page-076_2R.jpg ../images/a1JpgQ403.png
convert -crop 984x833+145+496 -resize x200 /tmp/st/a1JpgQ40/page-076_2R.jpg ../images/a1JpgQ404.jpg
convert -crop 100x100+310+635 -sample x200 /tmp/st/a1JpgQ40/page-076_2R.jpg ../images/a1JpgQ405.jpg
