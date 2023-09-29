#!/usr/bin/env bash

set -e

install_zoxide() {
  local NAME="ZOXIDE"
  local FOLDER="pkgs/terminal/zoxide"
  local CODE="\$(zoxide init zsh)"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "zoxide --version"
  write_on_zshrc "$CODE"

  printSectionEnd "$NAME successfully configured"
}

