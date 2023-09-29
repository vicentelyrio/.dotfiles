#!/usr/bin/env bash

set -e

install_neofetch() {
  local NAME="NEOFETCH"
  local FOLDER="pkgs/terminal/neofetch"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "neofetch --version"

  printSectionEnd "$NAME successfully configured"
}

