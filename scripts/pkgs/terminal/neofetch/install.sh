#!/usr/bin/env bash

set -e

install_neofetch() {
  local NAME="NEOFETCH"
  local FOLDER="pkgs/terminal/neofetch"

  printLine
  printMessage "Installing $NAME"

  # install
  if ! command -v neofetch --version &> /dev/null; then
    brew bundle --file $(require "$FOLDER/Brewfile")
  fi

  printLine
  printSuccess "$NAME successfully installed"
}

