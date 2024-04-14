#!/usr/bin/env bash

set -e

install_transmission () {
  local NAME="Transmission"
  local FOLDER="pkgs/utilities/transmission"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list transmission"

  printSectionEnd "$NAME successfully configured"
}

