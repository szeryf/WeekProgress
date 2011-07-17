#!/bin/sh -x
rm -v icon{,-114,-57}.png
composite -verbose -gravity center progress-bar-bg.png progress-bar.png icon.png
composite -verbose -geometry "10x20+86+140" bar-left-1.png icon.png icon.png
composite -verbose -geometry "260x20!+96+140" bar-middle-10.png icon.png icon.png
composite -verbose -geometry "10x20+356+140" bar-right-1.png icon.png icon.png
convert -verbose -crop 450x120+60+90 -resize 114x114! icon.png icon-114.png
convert -verbose -crop 450x120+60+90 -resize 57x57! icon.png icon-57.png
# convert -verbose -crop 450x120+60+90 icon.png -resize 512x512! icon.png
# convert -verbose icon.png -gravity center -fill white -pointsize 50 -font fixed -draw 'text 0,100 "70%"' iconTunesArtwork.png
convert -verbose -crop 300x300+90+0 screenshot.png  iconTunesArtwork.png
convert -verbose -extract 40x40+60+130 screenshot.png left-end.png
composite -verbose -geometry 40x40+0+130 left-end.png iconTunesArtwork.png iconTunesArtwork.png
convert -verbose -extract 40x40+380+130 screenshot.png right-end.png
composite -verbose -geometry 40x40+260+130 right-end.png iconTunesArtwork.png iconTunesArtwork.png
convert -resize 512x512! iconTunesArtwork.png iconTunesArtwork.png
#composite -verbose -gravity center mask175.png iconTunesArtwork.png iconTunesArtwork.png
open iconTunesArtwork.png