#!/usr/bin/env bash

set -e

install_ack () {
  local NAME="ACK"
  local FOLDER="pkgs/terminal/ack"
  local FILE=".zshaliases"
  local HOMEFOLDER=${ZDOTDIR:-${HOME}}
  local DESTFILE="${HOMEFOLDER}/${FILE}"

  printLine
  printMessage "Installing $NAME"
  
  if ! command -v ack --version &> /dev/null; then
    brew bundle --file $(require "$FOLDER/Brewfile")
  fi

  cat $(require "${FOLDER}/${FILE}") >> ${DESTFILE}

  printLine
  printSuccess "$NAME successfully installed"
}

