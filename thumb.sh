#!/bin/bash
i=0
for filename in $1/*; do
	[ -e "$filename" ] || continue
	convert $filename -crop 10240x10240+1250+1250 +repage tmp.png
	convert tmp-0.png -resize 1024x1024 ${filename}_smaller.jpg
	rm tmp-*.png
	let i++
	echo Done thumbnail for $filename
done	
