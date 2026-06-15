#!/bin/bash

# Logitech device manager
solaar --window=hide &

# Clipboard manager
clipse -listen &

# XDG portals (must start after compositor)
sleep 1
/usr/lib/xdg-desktop-portal-gnome &
sleep 0.5
/usr/lib/xdg-desktop-portal &

# GTK theme
gsettings set org.gnome.desktop.interface gtk-theme "catppuccin-macchiato-lavender-standard+default"
gsettings set org.gnome.desktop.interface cursor-theme "Catppuccin-Macchiato-Dark-Cursors"
gsettings set org.gnome.desktop.interface cursor-size 24
gsettings set org.gnome.desktop.interface font-name "JetBrainsMono Nerd Font 13"

# Shell
noctalia-shell &
