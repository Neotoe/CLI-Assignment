#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Error: Please provide log file name."
    exit 1
fi

logfile=$1

if [ ! -f "$logfile" ]; then
    echo "Error: File does not exist."
    exit 1
fi

if [ ! -r "$logfile" ]; then
    echo "Error: File is not readable."
    exit 1
fi

total_entries=$(wc -l < "$logfile")
info_count=$(grep -c " INFO " "$logfile")
warning_count=$(grep -c " WARNING " "$logfile")
error_count=$(grep -c " ERROR " "$logfile")

recent_error=$(grep " ERROR " "$logfile" | tail -1)

echo "Total entries: $total_entries"
echo "INFO messages: $info_count"
echo "WARNING messages: $warning_count"
echo "ERROR messages: $error_count"

if [ -n "$recent_error" ]; then
    echo "Most recent ERROR: $recent_error"
else
    echo "No ERROR messages found."
fi

date_today=$(date +%Y-%m-%d)
report_file="logsummary_${date_today}.txt"

{
echo "Log Summary Report"
echo "Date: $date_today"
echo "---------------------"
echo "Total entries: $total_entries"
echo "INFO messages: $info_count"
echo "WARNING messages: $warning_count"
echo "ERROR messages: $error_count"
echo "Most recent ERROR: $recent_error"
} > "$report_file"

echo "Report generated: $report_file"
