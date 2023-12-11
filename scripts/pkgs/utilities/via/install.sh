#!/usr/bin/env bash

set -e

install_via () {
  local NAME="VIA Keyboard"
  local FOLDER="pkgs/utilities/via"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list via"

  printSectionEnd "$NAME successfully configured"
}

