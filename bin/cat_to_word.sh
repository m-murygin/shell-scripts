#!/bin/bash

if [[ ! $1 ]]; then
	echo "You should provide target file" >&2
	exit 1
fi

if [[ ! $2 ]]; then
	echo "You should provide target word" >&2
	exit 1	
fi

found=
while read -r; do
	if [[ ! $found ]]; then
		if [[ $REPLY =~ $2 ]]; then
			echo "$REPLY"
			found="yes"
		else 
			continue
		fi
	else
		echo "$REPLY"
	fi
done < $1

exit 0
