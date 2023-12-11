#!/usr/bin/env bash

set -e

install_nvm () {
  local NAME="Nvm"
  local FOLDER="pkgs/code/nvm"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "nvm --version"

  printSectionEnd "$NAME successfully configured"
}

