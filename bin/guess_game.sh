#!/bin/bash

declare -ri target=$(( ($RANDOM % 100) + 1))

echo "Start game"

declare -i guess=0

until [[ $guess -eq $target ]]; do
    read -r -p "Try to guess number between 1 and 100: " guess

    # if guess 0, that we have not an integer value
    ((guess)) || continue

    if (( guess < target )); then
        echo "Higher!"
    elif (( guess > target )); then
        echo "Lower!"
    fi
done

echo "You guessed. The hidden number is $target"
exit 0
