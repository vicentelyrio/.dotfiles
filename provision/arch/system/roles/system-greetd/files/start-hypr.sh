#!/bin/sh
source /home/vicentelyrio/.config/themes/theme.conf
env > /tmp/greet_env.log
exec Hyprland -c /etc/greetd/hyprland.conf
