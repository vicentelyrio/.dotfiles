#!/usr/bin/env bash

set -e

install_bat () {
  local NAME="BAT"
  local FOLDER="pkgs/terminal/bat"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "bat --version"
  install_on_zshaliases "#bat" "$FOLDER"

  printSectionEnd "$NAME successfully configured"
}

