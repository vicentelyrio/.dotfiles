#!/usr/bin/env bash

set -e

install_nvim () {
  local NAME="NVIM"
  local FOLDER="pkgs/ide/nvim"
  local FILE=".tmux.conf"
  local HOMEFOLDER=${ZDOTDIR:-${HOME}}
  local DESTFILE="${HOMEFOLDER}/${FILE}"
  local ALIASESFILE=".zshaliases"
  local ZSHALIASES="${HOMEFOLDER}/.config/.zsh/${ALIASESFILE}"
  local CODE="alias tk="

  printLine
  printMessage "Installing $NAME"
  
  # Install packages
  if ! command -v which tmux &> /dev/null; then
    brew bundle --file $(require "$FOLDER/Brewfile")
  fi

  # backup config
  if [ -f ${DESTFILE} ]; then
    printMessage "Backup current $FILE"
    mv ${DESTFILE} "${DESTFILE}.bkp.dotfiles"
  fi

  # copy config
  cp $(require "${FOLDER}/${FILE}") ${DESTFILE}

  # include aliases
  if ! grep -q "$CODE" "$ZSHALIASES"; then
    cat $(require "${FOLDER}/${ALIASESFILE}") >> ${ZSHALIASES}
  fi
  
  printLine
  printSuccess "$NAME successfully installed"
}

