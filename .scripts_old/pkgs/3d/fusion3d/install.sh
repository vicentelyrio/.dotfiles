#!/usr/bin/env bash

set -e

install_fusion3d () {
  local NAME="Fusion 3D"
  local FOLDER="pkgs/3d/fusion3d"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list autodesk-fusion360"

  printSectionEnd "$NAME successfully configured"
}

