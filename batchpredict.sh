#!/bin/bash
DARKGRAY='\033[1;30m'
RED='\033[0;31m'
BLUE='\033[0;34m'
SET='\033[0m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'

i=0
for img in $1/*.jpg; do
	let i++
	c=$(predict.py $img 2>/dev/null|tail -c 3 |head -c 1)
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
