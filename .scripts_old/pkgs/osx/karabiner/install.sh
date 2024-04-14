#!/usr/bin/env bash

set -e

install_karabiner () {
  local NAME="Karabiner"
  local FOLDER="pkgs/osx/karabiner"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list karabiner-elements"

  printSectionEnd "$NAME successfully configured"
}

