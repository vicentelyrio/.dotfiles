#!/bin/bash

workspaces="$(hyprctl workspaces -j | jq '.[] | del(select(.id == -99)) | .id')"

# Remove leading and trailing whitespace
workspaces=$(echo "$workspaces" | sed 's/^[ \t]*//;s/[ \t]*$//')

# Convert newlines to commas
workspaces=$(echo "$workspaces" | tr '\n' ',')

# Remove the trailing comma
workspaces=${workspaces%,}

# Extract the minimum and maximum values
min_value=1
max_value=$(echo "$workspaces" | tr ',' '\n' | sort -n | tail -n 1)

# Generate the sequence and fill gaps
filled_sequence=$(seq -s, "$min_value" "$max_value")

# Add square brackets
result="[$filled_sequence]"

echo "$result"
