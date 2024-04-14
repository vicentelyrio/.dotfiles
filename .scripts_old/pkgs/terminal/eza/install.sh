#!/usr/bin/env bash

set -e

install_eza () {
  local NAME="EZA"
  local FOLDER="pkgs/terminal/eza"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "eza --version"
  install_on_zshaliases "#eza" "$FOLDER"

  printSectionEnd "$NAME successfully configured"
}

