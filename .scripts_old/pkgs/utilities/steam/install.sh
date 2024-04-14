#!/usr/bin/env bash

set -e

install_steam () {
  local NAME="Steam"
  local FOLDER="pkgs/utilities/steam"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list steam"

  printSectionEnd "$NAME successfully configured"
}

