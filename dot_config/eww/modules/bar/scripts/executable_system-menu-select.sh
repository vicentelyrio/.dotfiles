#!/bin/bash

option="$1"

case $option in
  "System")
    flatpak run io.missioncenter.MissionCenter &
    ;;
  "Theme")
    nwg-look &
    ;;
  "Sleep")
    systemctl hibernate
    ;;
  "Restart")
    systemctl reboot
    ;;
  "Shutdown")
    systemctl poweroff
    ;;
  "Lock")
    swaylock &
    ;;
  "Logout")
    hyprctl dispatch exit
    ;;
esac

source "$HOME/.config/eww/modules/bar/scripts/system-menu-close.sh"

