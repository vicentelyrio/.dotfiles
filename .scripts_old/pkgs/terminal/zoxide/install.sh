#!/usr/bin/env bash

set -e

install_zoxide() {
  local NAME="ZOXIDE"
  local FOLDER="pkgs/terminal/zoxide"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "zoxide --version"
  install_on_zshrc "#zoxide" "$FOLDER"

  printSectionEnd "$NAME successfully configured"
}

