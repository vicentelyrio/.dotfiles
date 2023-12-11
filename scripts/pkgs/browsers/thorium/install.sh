#!/usr/bin/env bash

set -e

install_thorium () {
  local NAME="Thorium"
  local FOLDER="pkgs/browsers/thorium"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "brew list thorium"

  printSectionEnd "$NAME successfully configured"
}

