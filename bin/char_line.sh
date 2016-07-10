#!/bin/bash

# Prints the line of characters with specific length
# The default char is "-"

length="$1"
if [[ ! $length ]]; then
    echo "You should provide the length of line" >&2
    exit 1
fi

# check that first argument is a number
if [[ ! $length =~ ^[0-9]+$ ]]; then
    echo "Length has to be a number" >&2
    exit 1
fi

char="-"
if [[ $2 ]]; then
    char="$2"
fi

line=""
for (( i = 0; i < $length; i++ )); do
    line="${line}${char}"
done

echo $line

exit 0