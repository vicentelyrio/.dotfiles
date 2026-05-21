#!/usr/bin/env bash
# Launches the user's Hyprland session after greetd authentication.

set -u

ZSHENV="${HOME}/.zshenv"
if [ -r "$ZSHENV" ]; then
  # shellcheck disable=SC1090
  . "$ZSHENV"
fi

exec start-hyprland
