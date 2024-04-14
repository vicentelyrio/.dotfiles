#!/usr/bin/env bash

set -e

install_gtop() {
  local NAME="GTOP"
  local FOLDER="pkgs/terminal/gtop"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "gtop --version"

  printSectionEnd "$NAME successfully configured"
}

