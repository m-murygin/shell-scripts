#!/bin/bash

# Attempts to count the lines of output of any given argument

declare -i count=0

count_lines() {
    while read -r; do
        ((++count))
    done
    echo $count
}

$* | count_lines
echo $count
