#!/usr/bin/env bash

set -e

install_nvim () {
  local NAME="NVIM"
  local FOLDER="pkgs/ide/nvim"

  printLine
  printMessage "Installing $NAME"

  # Install packages
  if ! command -v nvim --version &> /dev/null; then
    brew bundle --file $(require "$FOLDER/Brewfile")
  fi

  printLine
  printSuccess "$NAME successfully installed"
}

