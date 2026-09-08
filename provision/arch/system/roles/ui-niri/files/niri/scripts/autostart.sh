#!/bin/bash

# Input method (needed for the ~/.XCompose cedilla override to apply to
# GTK4/Wayland-native apps, e.g. Ghostty; GTK's old built-in "cedilla" IM
# module never supported GTK4)
fcitx5 -d --replace &

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
gsettings set org.gnome.desktop.interface font-name "JetBrainsMono Nerd Font 16"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

# Shell
qs -c noctalia-shell &
