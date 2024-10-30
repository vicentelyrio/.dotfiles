#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <folder-path> <workspace-number>"
  exit 1
fi

FOLDER=$1
WORKSPACE=$2
WINDOW_CLASS="alacritty_scratchpad_$WORKSPACE"
PROGRAM=${3:-}

# Set a Hyprland rule to force Alacritty windows to the specified workspace
hyprctl keyword windowrule "workspace $WORKSPACE silent, $WINDOW_CLASS"

open_alacritty_hyprland() {
  if [ -z "$PROGRAM" ]; then
    alacritty --class "$WINDOW_CLASS" --working-directory "$(zoxide query "$FOLDER")" &
  else
    alacritty --class "$WINDOW_CLASS" --working-directory "$(zoxide query "$FOLDER")" -e "$PROGRAM" &
  fi

  sleep 0.2
}

open_alacritty_hyprland

# Clear the rule after running, so it doesn't affect future Alacritty windows
hyprctl keyword windowrule "unset, $WINDOW_CLASS"

