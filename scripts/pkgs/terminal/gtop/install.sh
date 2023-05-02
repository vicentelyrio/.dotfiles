#!/usr/bin/env bash

set -e

install_gtop() {
  local NAME="GTOP"
  local FOLDER="pkgs/terminal/gtop"

  printLine
  printMessage "Installing $NAME"

  # install
  if ! command -v gtop --version &> /dev/null; then
    brew bundle --file $(require "$FOLDER/Brewfile")
  fi

  printLine
  printSuccess "$NAME successfully installed"
}

