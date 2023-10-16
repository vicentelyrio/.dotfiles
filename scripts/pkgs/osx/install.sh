#!/usr/bin/env bash

set -e

# shellcheck source=/scripts/pkgs/osx/quicklook/install.sh
source "$(require "pkgs/osx/quicklook/install.sh")"

installOsxStuffExec () {
  local OSX_NAME="OSX Stuff"

  printSection "Installing $OSX_NAME"

  install_quicklook

  printSection "✓ $OSX_NAME successfully installed"
}

installOsxStuff() {
  local OSX_NAME="OSX Stuff"

  if ! [ "$OS" == "OSX" ]; then
    return
  fi

  printQuestion "Do you want to install $OSX_NAME?"

  local YES="Yes"
  local NO="No"

  local ACTIONS

  ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " "$YES" "$NO")

  if [ "$ACTIONS" == $YES ]; then
    installOsxStuffExec
  fi
}

