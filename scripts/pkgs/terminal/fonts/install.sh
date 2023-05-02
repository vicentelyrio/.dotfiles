#!/usr/bin/env bash

set -e

install_fonts () {
  local NAME="Nerd Fonts"
  local FOLDER="pkgs/terminal/fonts"

  printLine
  printMessage "Installing $NAME"

  # install
  if ! command -v tree --version &> /dev/null; then
    brew bundle --file $(require "$FOLDER/Brewfile")
  fi

  printLine
  printSuccess "$NAME successfully installed"
}

