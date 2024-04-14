#!/usr/bin/env bash

set -e

install_nvim () {
  local NAME="Neovim"
  local FOLDER="pkgs/ide/nvim"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "nvim --version"
  install_on_zshaliases "#nvim" "$FOLDER"

  # install personal config
  local dest="${HOMEFOLDER}/.config/nvim"

  gum spin --spinner minidot --title "Installing vicentelyrio/nvim..." -- git clone vicentelyrio/nvim "$dest"

  printSectionEnd "$NAME successfully configured"
}

