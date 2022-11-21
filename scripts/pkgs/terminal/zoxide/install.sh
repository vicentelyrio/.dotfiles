#!/usr/bin/env bash

set -e

install_zoxide() {
  local NAME="ZOXIDE"
  local FOLDER="pkgs/terminal/zoxide"

  printLine
  printMessage "Installing $NAME"
  
  brew bundle --file $(require "$FOLDER/Brewfile")
  
  echo "eval \$(zoxide init zsh)" >> ~/.zprofile

  printLine
  printSuccess "$NAME successfully installed"
}

