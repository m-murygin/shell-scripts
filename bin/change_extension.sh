#!/bin/bash

# Change filename extension

if [[ $# -ne 2 ]]; then
    echo "You should provide exactly 2 arguments" >&2
    exit 1
fi

for f in *"$1"; do
    base=$(basename "$f" "$1")
    mv "$f" "${base}$2"
done

exit 0
