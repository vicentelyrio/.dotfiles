#!/bin/bash

signal_strength=$(nmcli -t -f SIGNAL,ACTIVE device wifi | awk -F ':' '{if($2=="yes")print$1}')

if [ -z "$signal_strength" ]; then
  echo "󰤮"
else
  if (( signal_strength <= 20 )); then
    echo "󰤯"
  elif (( signal_strength <= 40 )); then
    echo "󰤟"
  elif (( signal_strength <= 60 )); then
    echo "󰤢"
  else
    echo "󰤨"
  fi
fi
