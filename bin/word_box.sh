#!/bin/bash

# Draws a box around word
# Usage: ./word_box.sh hello

[[ $1 ]] || { echo "You should provide argument" >&2; exit 1; }

draw_line_around_word () {
    declare char="="
    declare line=""

    for (( i = 0; i < $1; i++ )); do
        line+=$char
    done

    printf "%s\n" $line
}

line_length=$(( ${#1} + 4 ))
draw_line_around_word $line_length 
printf "| %s |\n" $1
draw_line_around_word $line_length
 