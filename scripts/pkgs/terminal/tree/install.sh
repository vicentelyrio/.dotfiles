#!/usr/bin/env bash

set -e

install_tree () {
  local NAME="TREE"
  local FOLDER="pkgs/terminal/tree"

  printLine
  printMessage "Installing $NAME"

  # install
  if ! command -v tree --version &> /dev/null; then
    brew bundle --file $(require "$FOLDER/Brewfile")
  fi

  printLine
  printSuccess "$NAME successfully installed"
}

