#!/usr/bin/env bash
# Catppuccin Macchiato lock screen. Invoked by swayidle's `lock` handler, so
# `loginctl lock-session`, the idle timer and Mod+Escape all land here.

set -u

pgrep -x swaylock >/dev/null 2>&1 && exit 0

# The effects flags below need swaylock-effects. Fall back to a plain locked
# screen if only upstream swaylock is present — never leave the session open.
swaylock \
  --daemonize \
  --screenshots \
  --clock \
  --indicator \
  --effect-blur 7x5 \
  --effect-vignette 0.5:0.5 \
  --fade-in 0.2 \
  --indicator-radius 100 \
  --indicator-thickness 8 \
  --ring-color b7bdf8 \
  --ring-ver-color 8aadf4 \
  --ring-wrong-color ed8796 \
  --ring-clear-color f5a97f \
  --key-hl-color a6da95 \
  --bs-hl-color ed8796 \
  --inside-color 24273a99 \
  --inside-ver-color 24273a99 \
  --inside-wrong-color 24273a99 \
  --inside-clear-color 24273a99 \
  --text-color cad3f5 \
  --text-ver-color cad3f5 \
  --text-wrong-color cad3f5 \
  --text-clear-color cad3f5 \
  --line-color 00000000 \
  --separator-color 00000000 \
  --font "JetBrainsMono Nerd Font" ||
  exec swaylock --daemonize --color 24273a
