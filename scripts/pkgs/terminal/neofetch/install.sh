#!/usr/bin/env bash

set -e

install_neofetch() {
  local NAME="NEOFETCH"
  local FOLDER="pkgs/terminal/neofetch"

  printLine
  printMessage "Installing $NAME"
  
  brew bundle --file $(require "$FOLDER/Brewfile")

  printLine
  printSuccess "$NAME successfully installed"
}

