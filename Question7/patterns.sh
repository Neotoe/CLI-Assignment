#!/bin/bash

file="input.txt"

if [ ! -f "$file" ]; then
    echo "Error: input.txt not found."
    exit 1
fi

# Clear output files
> vowels.txt
> consonants.txt
> mixed.txt

# Convert file into one word per line
words=$(tr -c 'A-Za-z' '\n' < "$file" | grep -v '^$')

for word in $words
do
    lower=$(echo "$word" | tr 'A-Z' 'a-z')

    # Only vowels
    if [[ "$lower" =~ ^[aeiou]+$ ]]; then
        echo "$word" >> vowels.txt

    # Only consonants
    elif [[ "$lower" =~ ^[bcdfghjklmnpqrstvwxyz]+$ ]]; then
        echo "$word" >> consonants.txt

    # Mixed but starting with consonant
    elif [[ "$lower" =~ ^[bcdfghjklmnpqrstvwxyz] && "$lower" =~ [aeiou] && "$lower" =~ [bcdfghjklmnpqrstvwxyz] ]]; then
        echo "$word" >> mixed.txt
    fi
done

echo "Processing completed."
