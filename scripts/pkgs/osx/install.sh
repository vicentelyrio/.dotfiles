#!/usr/bin/env bash

set -e

# shellcheck source=/scripts/pkgs/osx/quicklook/install.sh
source "$(require "pkgs/osx/quicklook/install.sh")"

OSX_NAME="OSX Stuff"

installOsxStuffExec () {
  printLine
  printMessage "Installing $OSX_NAME"

  install_quicklook

  printLine
  printSuccess "$OSX_NAME successfully installed"
}

installOsxStuff() {
  if ! [ "$OS" == "OSX" ]; then
    return
  fi

  printLine
  printQuestion "Do you want to install $OSX_NAME?"

  local YES="Yes"
  local NO="No"

  local ACTIONS

  ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " "$YES" "$NO")

  if [ "$ACTIONS" == $YES ]; then
    installOsxStuffExec
  fi
}

