#!/bin/bash

# Check argument count
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

dir="$1"

# Check directory exists
if [ ! -d "$dir" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

backup_dir="$dir/backup"
mkdir -p "$backup_dir"

echo "Parent Script PID: $$"

# Move each file in background
for file in "$dir"/*
do
    # Skip backup directory itself
    if [ -f "$file" ]; then
        mv "$file" "$backup_dir" &
        echo "Moving $(basename "$file") in background. PID: $!"
    fi
done

# Wait for all background jobs to finish
wait

echo "All background move operations completed."
