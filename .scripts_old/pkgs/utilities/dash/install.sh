#!/usr/bin/env bash

set -e

install_dash () {
  local NAME="Dash (offline docs)"
  local FOLDER="pkgs/utilities/dash"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list dash"

  printSectionEnd "$NAME successfully configured"
}

