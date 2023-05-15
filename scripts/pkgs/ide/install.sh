#!/usr/bin/env bash

set -e

source $(require "pkgs/ide/nvim/install.sh")

IDE_NAME="IDEs"

installIDEsExec () {
  printLine
  printMessage "Installing $IDE_NAME"

  install_nvim

  printLine
  printSuccess "$IDE_NAME successfully installed"
}

installIDEs() {
  printLine
  printQuestion "Do you want to install $IDE_NAME?"

  local YES="Yes"
  local NO="No"

  local ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " "$YES" "$NO")

  if [ $ACTIONS == $YES ]; then
    installIDEsExec
  fi
}
