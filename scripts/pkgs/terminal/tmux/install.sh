#!/usr/bin/env bash

set -e

install_tmux () {
  local NAME="TMUX"
  local FOLDER="pkgs/terminal/tmux"
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
  cp $(require "${FOLDER}/.zshaliases") "${HOMEFOLDER}/.zshaliases"
  
  printLine
  printSuccess "$NAME successfully installed"
}

