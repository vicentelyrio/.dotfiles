#!/usr/bin/env bash
# Greetd session launcher for the Hyprland-based greeter.
# Runs as the user defined in /etc/greetd/config.toml.

set -u

THEME_FILE="${HOME}/.config/themes/theme.conf"
if [ -r "$THEME_FILE" ]; then
  # shellcheck disable=SC1090
  . "$THEME_FILE"
fi

# Debug: capture environment for troubleshooting greeter failures.
env > "/tmp/greet_env.${USER}.log" 2>/dev/null || true

exec start-hyprland -c /etc/greetd/hyprland.conf
