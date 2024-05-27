#!/bin/bash

# Automounter for removable media
# udiskie &

# Plugins
# pypr &

# Notification Daemon
# swaync &

# OSD Window
# swayosd-server &

# Notify about devices connecting and disconnecting
# devify &

# Solaar start (logitech bolt manager)
solaar --window=hide

# Interface
$HOME/.config/ags/scripts/start.sh

# Idle daemon to screen lock
hypridle &

# Wallpaper daemon
hyprpaper &

# Screen sharing and portals
# "$scripts"/portal &
# xwaylandvideobridge &
