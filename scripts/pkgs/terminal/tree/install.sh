#!/usr/bin/env bash

set -e

install_tree () {
  local NAME="TREE"
  local FOLDER="pkgs/terminal/tree"

  printLine
  printMessage "Installing $NAME"
  
  brew bundle --file $(require "$FOLDER/Brewfile")

  printLine
  printSuccess "$NAME successfully installed"
}

