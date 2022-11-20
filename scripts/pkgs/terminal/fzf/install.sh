#!/usr/bin/env bash

set -e

install_fzf () {
  local NAME="FZF"
  local FOLDER="pkgs/terminal/fzf"
  local FILE=".fzf.zsh"
  local HOMEFOLDER=${ZDOTDIR:-${HOME}}
  local DESTFILE="${HOMEFOLDER}/${FILE}"

  printLine
  printMessage "Installing $NAME"
 
  # install fzf
  brew bundle --file $(require "$FOLDER/Brewfile")

  # install autocompletion
  $(brew --prefix)/opt/fzf/install --all

  # install theme
  cat $(require "${FOLDER}/${FILE}") >> ${DESTFILE}

  printLine
  printSuccess "$NAME successfully installed"
}

