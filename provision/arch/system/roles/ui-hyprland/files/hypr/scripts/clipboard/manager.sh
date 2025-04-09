#!/bin/bash

# Maximum clipboard size in bytes (adjust as needed, this is ~10MB)
MAX_SIZE=10485760

# Start clipman if not already running
if ! pgrep -f "wl-paste .* clipman" > /dev/null; then
  wl-paste --type text --watch clipman store &
  wl-paste --type image --watch clipman store &
fi

# Optional: Add size limiting for very large content
wl-paste --watch bash -c '
  content=$(cat)
  size=${#content}
  if [ "$size" -gt '$MAX_SIZE' ]; then
    echo "Clipboard content exceeds size limit ($(($size/1024/1024))MB). Truncating."
    echo "${content:0:'$MAX_SIZE'}" | wl-copy
  fi
'
