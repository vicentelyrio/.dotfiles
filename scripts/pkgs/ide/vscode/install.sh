#!/usr/bin/env bash

set -e

install_vscode () {
  local NAME="VSCODE"
  local FOLDER="pkgs/ide/vscode"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "code --version"

  printSectionEnd "$NAME successfully configured"
}

