#!/bin/bash

# Get current brightness
current_brightness=$(light -G)
# Convert brightness to integer for simplicity
current_brightness=${current_brightness%.*}

# Define the duration of the fade-out (in seconds)
duration=1
# Define the number of steps
steps=10
# Calculate the sleep duration between steps using awk
sleep_duration=$(awk "BEGIN {print $duration / $steps}")

# Calculate the step size for each iteration using awk
step_size=$(awk "BEGIN {print $current_brightness / $steps}")

# Loop to decrease brightness gradually using interpolation
for (( i=0; i<=steps; i++ )); do
  new_brightness=$(awk "BEGIN {print $current_brightness - ($step_size * $i)}")
  new_brightness=${new_brightness%.*} # Convert to integer
  if [ $new_brightness -lt 0 ]; then
    new_brightness=0
  fi
  light -S $new_brightness
  sleep $sleep_duration
done
