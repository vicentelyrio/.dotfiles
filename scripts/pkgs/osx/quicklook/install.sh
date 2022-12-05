#!/usr/bin/env bash

set -e

install_quicklook () {
  local NAME="Quicklook plugins"
  local FOLDER="pkgs/osx/quicklook"

  printLine
  printMessage "Installing $NAME"
  
  # Install packages
  brew bundle --file $(require "$FOLDER/Brewfile")

  printLine
  printSuccess "$NAME successfully installed"
}

