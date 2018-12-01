#!/bin/bash
DARKGRAY='\033[1;30m'
RED='\033[0;31m'
BLUE='\033[0;34m'
SET='\033[0m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'

WD=/tmp/orto

mkdir -p /tmp/orto

filename=$1
[ -e "$filename" ] || exit 
convert $filename -crop 10240x10240+1250+1250 +repage ${WD}/tmp.png
convert ${WD}/tmp-0.png -resize 25% ${WD}/smaller.png
convert ${WD}/smaller.png -crop 256x256 +adjoin +repage ${WD}/t${i}_%04d.jpg
rm ${WD}/tmp-*.png
rm ${WD}/smaller.png
echo Done tiling $filename

i=0
for img in ${WD}/*.jpg; do
	let i++
	c=$(./predict.py $img 2>/dev/null|tail -c 3 |head -c 1)
	if [[ "$c" == 0 ]]; then
		echo -en ${YELLOW}▉▉${SET}
	elif [[ "$c" == 1 ]];then
		echo -en ${GREEN}▉▉${SET}
	elif [[ "$c" == 2 ]];then
		echo -en ${RED}▉▉${SET}
	else
		echo -en ${BLUE}▉▉${SET}
	fi

	if [[ "$i" == 10 ]]; then
		printf "\n"
		i=0
	fi
done	

rm -rf ${WD}
