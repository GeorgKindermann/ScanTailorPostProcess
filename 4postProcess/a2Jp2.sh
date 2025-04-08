#Convert the filtered images to jp2
mkdir /tmp/st/a2Jp2

mogrify -path /tmp/st/a2Jp2 -format jp2 /tmp/st/outA2/*.tif

# The same but using 7 cores
find /tmp/st/outA2/ -type f -name '*.tif' -print0 | xargs -0 -n7 -P7 mogrify -path /tmp/st/a2Jp2 -format jp2 -quality 40


#Get Size
du -bc /tmp/st/a2Jp2/*.jp2 #size: 85485002

#Extract sample pictures
convert -resize x200 /tmp/st/a2Jp2/page-076_2R.jp2 ../images/a2Jp21.jpg
convert -crop 520x520+130+3240 -resize x200 /tmp/st/a2Jp2/page-076_2R.jp2 ../images/a2Jp22.jpg
convert -crop 86x50+330+3530 -sample x200 /tmp/st/a2Jp2/page-076_2R.jp2 ../images/a2Jp23.png
convert -crop 1968x1666+290+992 -resize x200 /tmp/st/a2Jp2/page-076_2R.jp2 ../images/a2Jp24.jpg
convert -crop 200x200+620+1270 -sample x200 /tmp/st/a2Jp2/page-076_2R.jp2 ../images/a2Jp25.jpg
