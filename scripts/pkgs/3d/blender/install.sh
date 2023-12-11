#!/usr/bin/env bash

set -e

install_blender () {
  local NAME="Blender"
  local FOLDER="pkgs/3d/blender"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" ""

  printSectionEnd "$NAME successfully configured"
}

