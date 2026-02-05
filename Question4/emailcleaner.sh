#!/bin/bash

input_file="emails.txt"

if [ ! -f "$input_file" ]; then
    echo "Error: emails.txt not found."
    exit 1
fi

# Extract valid emails
grep -E '^[A-Za-z0-9]+@[A-Za-z]+\.com$' "$input_file" > valid.txt

# Extract invalid emails
grep -Ev '^[A-Za-z0-9]+@[A-Za-z]+\.com$' "$input_file" > invalid.txt

# Remove duplicates from valid emails
sort valid.txt | uniq > temp.txt
mv temp.txt valid.txt

echo "Processing completed."
