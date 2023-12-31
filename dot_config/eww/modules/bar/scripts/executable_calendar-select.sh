#!/bin/bash

source "$HOME/.config/eww/modules/bar/scripts/_run.sh"

day=$1
month=$2
year=$3

if [ "$#" -ne 3 ]; then
  return
else
  run_eww close calendar-closer
  run_eww close calendar

  flatpak run org.gnome.Calendar
fi

