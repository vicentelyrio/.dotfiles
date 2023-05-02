#!/usr/bin/env bash

set -e

install_ack () {
  local NAME="ACK"
  local FOLDER="pkgs/terminal/ack"
  local HOMEFOLDER=${ZDOTDIR:-${HOME}}
  local ALIASESFILE=".zshaliases"
  local ZSHALIASES="${HOMEFOLDER}/.config/.zsh/${ALIASESFILE}"
  local CODE="alias ack"

  printLine
  printMessage "Installing $NAME"

  if ! command -v ack --version &> /dev/null; then
    brew bundle --file $(require "$FOLDER/Brewfile")
  fi

  if ! grep -q "$CODE" "$ZSHALIASES"; then
    cat $(require "${FOLDER}/${ALIASESFILE}") >> ${ZSHALIASES}
  fi

  printLine
  printSuccess "$NAME successfully installed"
}

