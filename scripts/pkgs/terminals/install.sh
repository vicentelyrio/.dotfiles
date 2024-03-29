#!/usr/bin/env bash

set -e

# shellcheck source=/scripts/pkgs/terminals/alacritty/install.sh
source "$(require "pkgs/terminals/alacritty/install.sh")"

# shellcheck source=/scripts/pkgs/terminals/rio/install.sh
source "$(require "pkgs/terminals/rio/install.sh")"

# shellcheck source=/scripts/pkgs/terminals/wezterm/install.sh
source "$(require "pkgs/terminals/wezterm/install.sh")"

installTerminalsPackagesExec () {
  local NAME="Terminal Emulators"

  printSection "Installing $NAME"

  install_alacritty
  install_rio
  install_wezterm

  printSection "✓ $NAME successfully installed"
}

installTerminalsPackages () {
  printQuestion "Terminal Emulators"

  local ACTIONS

  local ALACRITTY="Alacritty"
  local WEZTERM="Wezterm"
  local RIO="Rio"

  ACTIONS=$(
    gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " --no-limit \
    "$WEZTERM" \
    "$ALACRITTY" \
    "$RIO" \
  )


  for element in "${ACTIONS[@]}"; do
    case "${element}" in
      "$ALACRITTY") install_alacritty ;;
      "$RIO") install_rio ;;
      "$WEZTERM") install_wezterm ;;
    esac
  done
}

