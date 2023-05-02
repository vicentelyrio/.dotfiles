#!/usr/bin/env bash

set -e

install_zoxide() {
  local NAME="ZOXIDE"
  local FOLDER="pkgs/terminal/zoxide"
  local HOMEFOLDER=${ZDOTDIR:-${HOME}}
  local ZSHRC="${HOMEFOLDER}/.zshrc"
  local CODE="\$(zoxide init zsh)"

  printLine
  printMessage "Installing $NAME"

  # install
  if ! command -v zoxide --version &> /dev/null; then
    brew bundle --file $(require "$FOLDER/Brewfile")
  fi

  if ! grep -q "$CODE" "$ZSHRC"; then
    echo "eval \"$CODE"\" >> "$ZSHRC"
  fi

  printLine
  printSuccess "$NAME successfully installed"
}

