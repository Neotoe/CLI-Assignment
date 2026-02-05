#!/bin/bash

file="input.txt"

# Check file exists
if [ ! -f "$file" ]; then
    echo "Error: input.txt not found."
    exit 1
fi

# Normalize text into one-word-per-line (letters/digits only)
words=$(tr -c 'A-Za-z0-9' '\n' < "$file" | grep -v '^$')

# Longest word
longest=$(echo "$words" | awk '{ if (length > max) { max=length; word=$0 } } END { print word }')

# Shortest word
shortest=$(echo "$words" | awk 'NR==1 { min=length; word=$0 } { if (length < min) { min=length; word=$0 } } END { print word }')

# Average word length
avg_len=$(echo "$words" | awk '{ total+=length; count++ } END { if (count>0) printf "%.2f", total/count; else print 0 }')

# Unique words count
unique_count=$(echo "$words" | tr 'A-Z' 'a-z' | sort | uniq | wc -l)

echo "Longest word: $longest"
echo "Shortest word: $shortest"
echo "Average word length: $avg_len"
echo "Total unique words: $unique_count"
