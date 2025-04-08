#Convert the filtered images to jp2
mkdir /tmp/st/a1Jp2

mogrify -path /tmp/st/a1Jp2 -format jp2 /tmp/st/outA1/*.tif

# The same but using 7 cores
find /tmp/st/outA1/ -type f -name '*.tif' -print0 | xargs -0 -n7 -P7 mogrify -path /tmp/st/a1Jp2 -format jp2 -quality 40


#Get Size
du -bc /tmp/st/a1Jp2/*.jp2 #size: 63727248

#Extract sample pictures
convert -resize x200 /tmp/st/a1Jp2/page-076_2R.jp2 ../images/a1Jp21.jpg
convert -crop 260x260+65+1620 -resize x200 /tmp/st/a1Jp2/page-076_2R.jp2 ../images/a1Jp22.jpg
convert -crop 43x25+165+1765 -sample x200 /tmp/st/a1Jp2/page-076_2R.jp2 ../images/a1Jp23.png
convert -crop 984x833+145+496 -resize x200 /tmp/st/a1Jp2/page-076_2R.jp2 ../images/a1Jp24.jpg
convert -crop 100x100+310+635 -sample x200 /tmp/st/a1Jp2/page-076_2R.jp2 ../images/a1Jp25.jpg
