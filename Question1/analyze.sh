#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Error: Please provide exactly one argument."
    exit 1
fi

path=$1

if [ ! -e "$path" ]; then
    echo "Error: Path does not exist."
    exit 1
fi

if [ -f "$path" ]; then
    echo "It is a file."
    echo "Lines: $(wc -l < "$path")"
    echo "Words: $(wc -w < "$path")"
    echo "Characters: $(wc -c < "$path")"

elif [ -d "$path" ]; then
    echo "It is a directory."

    total_files=$(find "$path" -type f | wc -l)
    txt_files=$(find "$path" -type f -name "*.txt" | wc -l)

    echo "Total files: $total_files"
    echo ".txt files: $txt_files"
fi
