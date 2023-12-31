#/bin/sh

if [ -f "/usr/bin/swayidle" ]; then
  swayidle -w \
    timeout 300 'swaylock -f' \
    timeout 360 'hyprctl dispatch dpms off' \
    resume 'hyprctl dispatch dpms on'
else
  echo "swayidle not installed: sudo pacman -S swayidle"
fi;
