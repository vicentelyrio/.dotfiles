#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <folder-path> <workspace-number|special>"
  exit 1
fi

FOLDER=$1
WORKSPACE=$2

# Function to open Alacritty
open_alacritty_hyprland() {
  if [ "$WORKSPACE" == "special" ]; then
    WINDOW_CLASS="stash"
    # Set a rule to assign the window to the scratchpad
    hyprctl keyword windowrule "workspace special silent, $WINDOW_CLASS"
    sleep 0.1  # Allow Hyprland to register the rule

    alacritty --class "$WINDOW_CLASS" --working-directory "$(zoxide query "$FOLDER")" &
    sleep 0.2  # Ensure the window is created

    # Use togglespecialworkspace to bring it into view
    hyprctl dispatch togglespecialworkspace stash

    # Clean up the rule
    hyprctl keyword windowrule "unset, $WINDOW_CLASS"
  else
    # Set a rule and open in a numbered workspace
    WINDOW_CLASS="alacritty_scratchpad_$WORKSPACE"
    hyprctl keyword windowrule "workspace $WORKSPACE silent, $WINDOW_CLASS"
    sleep 0.1

    alacritty --class "$WINDOW_CLASS" --working-directory "$(zoxide query "$FOLDER")" &
    sleep 0.2

    hyprctl keyword windowrule "unset, $WINDOW_CLASS"
  fi
}

# Execute the function
open_alacritty_hyprland

