#!/usr/bin/env bash

set -e

install_nvim () {
  local NAME="NEOVIM"
  local FOLDER="pkgs/ide/nvim"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "nvim --version"
  install_on_zshaliases "[#nvim]" "$FOLDER"

  printSectionEnd "$NAME successfully configured"
}

