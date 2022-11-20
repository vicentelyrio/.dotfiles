#!/usr/bin/env bash

set -e

install_zsh () {
  local NAME="ZSH"
  local FOLDER="pkgs/terminal/zsh"
  local FILE=".zshrc"
  local HOMEFOLDER=${ZDOTDIR:-${HOME}}
  local ZSHRCFILE="${HOMEFOLDER}/${FILE}"

  printLine
  printMessage "Installing $NAME"
  
  brew bundle --file $(require "$FOLDER/Brewfile")

  if [ -f ${ZSHRCFILE} ]; then
    printMessage "Backup current $FILE"
    mv ${ZSHRCFILE} "${ZSHRCFILE}.bkp.dotfiles"
  fi

  cp $(require "${FOLDER}/${FILE}") ${ZSHRCFILE}

  printLine
  printSuccess "$NAME successfully installed"
}

