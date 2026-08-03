#!/bin/bash

# Logitech device manager
solaar --window=hide &

# Clipboard manager
clipse -listen &

# Idle / lock daemon
"$HOME/.config/niri/scripts/idle.sh" &

# GTK theme
gsettings set org.gnome.desktop.interface gtk-theme "catppuccin-macchiato-lavender-standard+default"
gsettings set org.gnome.desktop.interface cursor-theme "catppuccin-macchiato-dark-cursors"
gsettings set org.gnome.desktop.interface cursor-size 24
gsettings set org.gnome.desktop.interface font-name "JetBrainsMono Nerd Font 13"

# Shell
noctalia-shell &
