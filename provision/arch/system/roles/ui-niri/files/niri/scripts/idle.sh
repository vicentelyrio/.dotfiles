#!/usr/bin/env bash
# Idle timeline, ported from the Hyprland hypridle.conf it replaces:
#   5:00  fade the backlight down
#   6:00  lock the session
#   7:00  DPMS off
#
# The 6:00 timer goes through `loginctl lock-session` rather than calling
# swaylock directly, so the timer and the Mod+Escape keybind both arrive at
# the same `lock` handler below and can never stack two lockers.

set -u

SCRIPTS="$HOME/.config/niri/scripts"

exec swayidle -w \
  timeout 300 "$SCRIPTS/fadeout.sh" resume "$SCRIPTS/fadein.sh" \
  timeout 360 'loginctl lock-session' \
  timeout 420 'niri msg action power-off-monitors' \
  resume 'niri msg action power-on-monitors' \
  before-sleep 'loginctl lock-session' \
  after-resume "$SCRIPTS/fadein.sh" \
  lock "$SCRIPTS/lock.sh"
