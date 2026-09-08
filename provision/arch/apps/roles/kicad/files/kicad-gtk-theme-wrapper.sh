#!/bin/sh
# KiCad's wxWidgets/GTK panels render with near-zero contrast under this
# dotfiles' dark Catppuccin GTK theme + prefer-dark color-scheme (sidebar
# text goes dark-on-dark). Force a known-good light theme for KiCad only,
# without touching the system-wide dark theme used by everything else.
export GTK_THEME="Adwaita:light"
export GSETTINGS_BACKEND=memory
exec "/usr/bin/$(basename "$0")" "$@"
