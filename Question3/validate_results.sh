#!/bin/bash

input_file="marks.txt"

if [ ! -f "$input_file" ]; then
    echo "Error: marks.txt not found."
    exit 1
fi

if [ ! -r "$input_file" ]; then
    echo "Error: marks.txt is not readable."
    exit 1
fi

fail_one_count=0
pass_all_count=0

echo "Students who failed in exactly ONE subject:"
echo "-------------------------------------------"

while IFS=',' read -r roll name m1 m2 m3
do
    fail_count=0

    if [ "$m1" -lt 33 ]; then ((fail_count++)); fi
    if [ "$m2" -lt 33 ]; then ((fail_count++)); fi
    if [ "$m3" -lt 33 ]; then ((fail_count++)); fi

    if [ "$fail_count" -eq 1 ]; then
        echo "$roll - $name"
        ((fail_one_count++))
    fi

    if [ "$fail_count" -eq 0 ]; then
        ((pass_all_count++))
    fi

done < "$input_file"

echo
echo "Students who passed in ALL subjects:"
echo "------------------------------------"

while IFS=',' read -r roll name m1 m2 m3
do
    if [ "$m1" -ge 33 ] && [ "$m2" -ge 33 ] && [ "$m3" -ge 33 ]; then
        echo "$roll - $name"
    fi
done < "$input_file"

echo
echo "Count Summary:"
echo "Students failed in exactly one subject: $fail_one_count"
echo "Students passed all subjects: $pass_all_count"
