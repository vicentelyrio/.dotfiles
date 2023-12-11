#!/usr/bin/env bash

set -e

install_origin () {
  local NAME="Origin"
  local FOLDER="pkgs/utilities/origin"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list origin"

  printSectionEnd "$NAME successfully configured"
}

