#!/usr/bin/env bash

set -e

install_fzf () {
  local NAME="FZF"
  local FOLDER="pkgs/terminal/fzf"
  local FILE=".fzf.zsh"
  local HOMEFOLDER=${ZDOTDIR:-${HOME}}
  local DESTFILE="${HOMEFOLDER}/${FILE}"
  local ZSHRC="${HOMEFOLDER}/.zshrc"

  printLine
  printMessage "Installing $NAME"

  # install fzf
  if ! command -v fzf --version &> /dev/null; then
    brew bundle --file $(require "$FOLDER/Brewfile")
  fi

  # install autocompletion
  $(brew --prefix)/opt/fzf/install --all --no-bash

  # install theme
  cat $(require "${FOLDER}/${FILE}") >> ${DESTFILE}

  printLine
  printSuccess "$NAME successfully installed"
}

