#!/bin/bash

# cats all lines before target, displays the rest part of the input stream
# 
# Use: ./cat_to_word.sh file_name cat_word

if [[ ! $1 ]]; then
	echo "You should provide target file" >&2
	exit 1
fi

if [[ ! $2 ]]; then
	echo "You should provide target word" >&2
	exit 1	
fi

found=
while read -r || [[ $REPLY ]]; do
	if [[ ! $found ]]; then
		if [[ $REPLY =~ $2 ]]; then
			echo "$REPLY"
			found="yes"
		else 
			continue
		fi
	fi

	echo "$REPLY"
done < "$1"

exit 0
