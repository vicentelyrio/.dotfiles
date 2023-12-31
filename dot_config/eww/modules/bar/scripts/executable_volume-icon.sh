#!/bin/bash

volume=$(pamixer --get-volume)

if (( volume <= 10 )); then
  echo ""
elif (( volume <= 60 )); then
  echo ""
elif (( volume <= 100 )); then
  echo ""
fi
