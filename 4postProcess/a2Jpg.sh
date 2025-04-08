#Convert the filtered images to jpg
mkdir /tmp/st/a2Jpg
mogrify -path /tmp/st/a2Jpg -format jpg /tmp/st/outA2/*.tif


#Get Size
du -bc /tmp/st/a2Jpg/*.jpg #size: 407846357

#Extract sample pictures
convert -resize x200 /tmp/st/a2Jpg/page-076_2R.jpg ../images/a2Jpg1.jpg
convert -crop 520x520+130+3240 -resize x200 /tmp/st/a2Jpg/page-076_2R.jpg ../images/a2Jpg2.jpg
convert -crop 86x50+330+3530 -sample x200 /tmp/st/a2Jpg/page-076_2R.jpg ../images/a2Jpg3.png
convert -crop 1968x1666+290+992 -resize x200 /tmp/st/a2Jpg/page-076_2R.jpg ../images/a2Jpg4.jpg
convert -crop 200x200+620+1270 -sample x200 /tmp/st/a2Jpg/page-076_2R.jpg ../images/a2Jpg5.jpg
