#!/usr/bin/env bash

set -e

install_zoxide() {
  local NAME="ZOXIDE"
  local FOLDER="pkgs/terminal/zoxide"
  local HOMEFOLDER=${ZDOTDIR:-${HOME}}
  local ZPROFILE="${HOMEFOLDER}/.zprofile"
  local CODE="\$(zoxide init zsh)"

  printLine
  printMessage "Installing $NAME"
  
  brew bundle --file $(require "$FOLDER/Brewfile")
  
  if ! grep -q "$CODE" "$ZPROFILE"; then
    echo "eval $CODE" >> "$ZPROFILE" 
  fi

  printLine
  printSuccess "$NAME successfully installed"
}

