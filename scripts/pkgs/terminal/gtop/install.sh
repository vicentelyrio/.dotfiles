#!/usr/bin/env bash

set -e

install_gtop() {
  local NAME="GTOP"
  local FOLDER="pkgs/terminal/gtop"

  printLine
  printMessage "Installing $NAME"
  
  brew bundle --file $(require "$FOLDER/Brewfile")

  printLine
  printSuccess "$NAME successfully installed"
}

