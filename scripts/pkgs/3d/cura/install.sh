#!/usr/bin/env bash

set -e

install_cura () {
  local NAME="Ultimaker Cura"
  local FOLDER="pkgs/3d/cura"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list ultimaker-cura"

  printSectionEnd "$NAME successfully configured"
}

