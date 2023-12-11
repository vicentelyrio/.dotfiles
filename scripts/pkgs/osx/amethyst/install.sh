#!/usr/bin/env bash

set -e

install_amethyst () {
  local NAME="Amethyst"
  local FOLDER="pkgs/osx/amethyst"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list amethyst"

  printSectionEnd "$NAME successfully configured"
}

