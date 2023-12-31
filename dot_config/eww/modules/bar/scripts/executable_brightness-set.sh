#!/bin/sh

if command -v ddcutil &>/dev/null; then
  ddcutil setvcp 10 $1
  ddcutil setvcp 12 $1
fi
