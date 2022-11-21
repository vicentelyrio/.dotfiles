#!/usr/bin/env bash

set -e

install_starship () {
  local NAME="STARSHIP"
  local FOLDER="pkgs/terminal/starship"
  local FILE="starship.toml"
  local HOMEFOLDER=${ZDOTDIR:-${HOME}}
  local DESTFILE="${HOMEFOLDER}/.config/${FILE}"
  local ZPROFILE="${HOMEFOLDER}/.zprofile"
  local CODE="\$(starship init zsh)"

  printLine
  printMessage "Installing $NAME"
  
  # install
  if ! command -v starship -V &> /dev/null; then
    brew bundle --file $(require "$FOLDER/Brewfile")
  fi

  # install config 
  if ! grep -q "$CODE" "$ZPROFILE"; then
    echo "eval $CODE" >> "$ZPROFILE" 
  fi

  # copy settings 
  cat $(require "${FOLDER}/${FILE}") >> ${DESTFILE}

  printLine
  printSuccess "$NAME successfully installed"
}

