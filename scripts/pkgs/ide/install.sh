#!/usr/bin/env bash

set -e

# shellcheck source=/scripts/pkgs/ide/helix/install.sh
source "$(require "pkgs/ide/helix/install.sh")"

# shellcheck source=/scripts/pkgs/ide/nvim/install.sh
source "$(require "pkgs/ide/nvim/install.sh")"

# shellcheck source=/scripts/pkgs/ide/vscode/install.sh
source "$(require "pkgs/ide/vscode/install.sh")"

installIdeExec () {
  local NAME="IDEs"

  printSection "Installing $NAME"

  install_helix
  install_nvim
  install_vscode

  printSection "✓ $NAME successfully installed"
}

installIDEs() {
  local NAME="IDEs"
  printQuestion "Choose what $NAME you want to install"

  local ACTIONS

  local HELIX="Helix"
  local NVIM="Nvim"
  local VSCODE="VSCODE"

  ACTIONS=$(
    gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " --no-limit \
    "$HELIX" \
    "$NVIM" \
    "$VSCODE" \
  )

  case "$ACTIONS" in
    "$HELIX") install_helix ;;
    "$NVIM") install_nvim ;;
    "$VSCODE") install_vscode ;;
  esac
}
