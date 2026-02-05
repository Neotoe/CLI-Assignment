#!/bin/bash

dirA="dirA"
dirB="dirB"

# Check directories exist
if [ ! -d "$dirA" ] || [ ! -d "$dirB" ]; then
    echo "Error: One or both directories do not exist."
    exit 1
fi

echo "Files only in dirA:"
comm -23 <(ls "$dirA" | sort) <(ls "$dirB" | sort)

echo
echo "Files only in dirB:"
comm -13 <(ls "$dirA" | sort) <(ls "$dirB" | sort)

echo
echo "Comparing common files:"
for file in $(ls "$dirA")
do
    if [ -f "$dirB/$file" ]; then
        cmp -s "$dirA/$file" "$dirB/$file"

        if [ $? -eq 0 ]; then
            echo "$file : Contents match"
        else
            echo "$file : Contents differ"
        fi
    fi
done
