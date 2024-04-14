#!/usr/bin/env bash

set -e

install_brave () {
  local NAME="Brave"
  local FOLDER="pkgs/browsers/brave"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list brave-browser"

  printSectionEnd "$NAME successfully configured"
}

