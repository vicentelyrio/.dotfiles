#!/usr/bin/env bash

set -e

# shellcheck source=/scripts/pkgs/ide/nvim/install.sh
source "$(require "pkgs/ide/nvim/install.sh")"

IDE_NAME="IDEs"

installIDEsExec () {
  printSection "Installing $IDE_NAME"

  install_nvim

  printSection "✓ $IDE_NAME successfully installed"
}

installIDEs() {
  printQuestion "Do you want to install $IDE_NAME?"

  local YES="Yes"
  local NO="No"
  local ACTIONS

  ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " "$YES" "$NO")

  if [ "$ACTIONS" == $YES ]; then
    installIDEsExec
  fi
}
