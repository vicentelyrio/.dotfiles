#!/usr/bin/env bash

set -e

install_bat () {
  local NAME="BAT"
  local FOLDER="pkgs/terminal/bat"
  local FILE=".zshaliases"
  local HOMEFOLDER=${ZDOTDIR:-${HOME}}
  local DESTFILE="${HOMEFOLDER}/.config/.zsh/${FILE}"

  printLine
  printMessage "Installing $NAME"
  
  if ! command -v bat --version &> /dev/null; then
    brew bundle --file $(require "$FOLDER/Brewfile")
  fi

  cat $(require "${FOLDER}/${FILE}") >> ${DESTFILE}

  printLine
  printSuccess "$NAME successfully installed"
}

