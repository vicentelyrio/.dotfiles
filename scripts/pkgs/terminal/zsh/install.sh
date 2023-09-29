#!/usr/bin/env bash

set -e

install_zsh () {
  local NAME="ZSH"
  local FOLDER="pkgs/terminal/zsh"
  local ZSHFILE=".zshrc"
  local ALIASESFILE=".zshaliases"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "zsh --version"
  install_config_bkp "$ZSHFILE" "$FOLDER" "$ZSHFILE"
  install_config_bkp "$ALIASESFILE" "$FOLDER" "/.config/.zsh/$ALIASESFILE"

  printSectionEnd "$NAME successfully configured"
}

source_zsh () {
  command -v source "${ZDOTDIR:-${HOME}}/.zshrc" &> /dev/null
}

