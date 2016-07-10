#!/bin/bash

hidden_number=$(($RANDOM % 100))

echo "Start game"

guess=-1

until [[ $guess -eq $hidden_number ]]; do
    read -r -p "Try to guess number between 0 and 99: " guess

    if [[ $guess -lt $hidden_number ]]; then
        echo "Your value is LESS than hidden number"
    elif [[ $guess -gt $hidden_number ]]; then
        echo "Your value is GREAT then hidden number"
    fi
done

echo "You guessed. The hidden number is $hidden_number"
exit 0
