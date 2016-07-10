#!/bin/bash

date=$(date)

# get the topic
topic="$1"

# filename to write to
filename="./${topic}notes.txt"

# Ask user for input
read -p "Your note:" note

if [[ $note ]]; then
    echo "$date: $note" >> "$filename"
    echo "Note '$note ' was saved to $filename"
else
    echo "No input; note wasn't saved." 1>&2
fi

exit 0