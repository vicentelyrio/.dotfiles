#!/bin/bash

# Automounter for removable media
# udiskie &

# Notify about devices connecting and disconnecting
# devify &

# Solaar start (logitech bolt manager)
solaar --window=hide &

# Idle daemon to screen lock
hypridle &

# Wallpaper daemon
hyprpaper &

# Keyboard map
# xremap $HOME/.config/xremap/config.toml --device /dev/input/event30 &

# Interface
$HOME/.config/ags/run/desktop-show.sh &

# GTK theme
# $HOME/.config/hypr/scripts/gtk/settings.sh &

# Screen sharing and portals
# "$scripts"/portal &
# xwaylandvideobridge &
