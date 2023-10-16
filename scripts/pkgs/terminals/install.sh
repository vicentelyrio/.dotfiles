#!/usr/bin/env bash

set -e

# shellcheck source=/scripts/pkgs/terminals/wezterm/install.sh
source "$(require "pkgs/terminals/wezterm/install.sh")"

# shellcheck source=/scripts/pkgs/terminals/alacritty/install.sh
source "$(require "pkgs/terminals/alacritty/install.sh")"

installTerminalsPackagesExec () {
  local NAME="Terminals"

  printSection "Installing $NAME"

  install_wezterm
  install_alacritty

  printSection "✓ $NAME successfully installed"
}

installTerminalsPackages () {
  local NAME="Terminals"
  printQuestion "Do you want to install $NAME?"

  local YES="Yes"
  local NO="No"
  local ACTIONS

  ACTIONS="$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " "$YES" "$NO")"

  if [ "$ACTIONS" == $YES ]; then
    installTerminalsPackagesExec
  fi
}

