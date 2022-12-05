#!/usr/bin/env bash

set -e

install_zsh () {
  local NAME="ZSH"
  local FOLDER="pkgs/terminal/zsh"
  local FILE=".zshrc"
  local HOMEFOLDER=${ZDOTDIR:-${HOME}}
  local DESTFILE="${HOMEFOLDER}/${FILE}"
  local ALIASESFILE=".zshaliases"
  local ZSHALIASES="${HOMEFOLDER}/.config/.zsh/${ALIASESFILE}"

  printLine
  printMessage "Installing $NAME"
  
  # install
  if ! command -v zsh --version &> /dev/null; then
    brew bundle --file $(require "$FOLDER/Brewfile")
  fi

  if [ -f ${DESTFILE} ]; then
    printMessage "Backup current $FILE"
    mv ${DESTFILE} "${DESTFILE}.dotfiles.bkp.${DATENOW}"
  fi

  # Create zshrc and aliases files
  cp $(require "${FOLDER}/${FILE}") ${DESTFILE}
  cp $(require "${FOLDER}/${ALIASESFILE}") "${ZSHALIASES}"
  
  printLine
  printSuccess "$NAME successfully installed"
}

