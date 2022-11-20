#!/usr/bin/env bash

set -e

install_zsh () {
  local NAME="ZSH"
  local FOLDER="pkgs/terminal/zsh"
  local FILE=".zshrc"
  local HOMEFOLDER=${ZDOTDIR:-${HOME}}
  local DESTFILE="${HOMEFOLDER}/${FILE}"

  printLine
  printMessage "Installing $NAME"
  
  brew bundle --file $(require "$FOLDER/Brewfile")

  if [ -f ${DESTFILE} ]; then
    printMessage "Backup current $FILE"
    mv ${DESTFILE} "${DESTFILE}.bkp.dotfiles"
  fi

  cp $(require "${FOLDER}/${FILE}") ${DESTFILE}

  printLine
  printSuccess "$NAME successfully installed"
}

