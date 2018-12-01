#!/bin/bash
i=0
filename=$1
[ -e "$filename" ] || exit 
convert $filename -crop 10240x10240+1250+1250 +repage tmp.png
convert tmp-0.png -resize 25% smaller.png
convert smaller.png -crop 256x256 +adjoin +repage t${i}_%04d.jpg
rm tmp-*.png
rm smaller.png
echo Done tiling $filename
