#!/bin/bash

declare -r date=$(date)

# get the topic
declare -r topic="$1"

# dir to store files to write to
notedir=${NOTEDIR:-${HOME}/notes}

if [[ ! -d $notedir ]]; then
    mkdir "${notedir}" 2> /dev/null || {
        echo "Cannot make directory ${notedir}" 1>&2;
        exit 1;
    }
fi

declare -r filename="${notedir}/${topic}notes.txt"

if [[ ! -f $filename ]]; then
    touch "${filename}" 2> /dev/null || {
        echo "Cannot create file with name ${filename}" 1>&2;
        exit 1;
    }
fi

# Ask user for input
read -p "Your note:" note

if [[ $note ]]; then
    echo "$date: $note" >> "$filename"
    echo "Note '$note ' was saved to $filename"
else
    echo "No input; note wasn't saved." 1>&2
fi

exit 0