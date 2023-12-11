#!/usr/bin/env bash

set -e

install_qmk () {
  local NAME="QMK Toolbox"
  local FOLDER="pkgs/utilities/qmk"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list qmk-toolbox"

  printSectionEnd "$NAME successfully configured"
}

