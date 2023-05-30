#!/usr/bin/env bash

set -e

install_bat () {
  local NAME="GITUI"
  local FOLDER="pkgs/terminal/gtiui"
  local HOMEFOLDER=${ZDOTDIR:-${HOME}}
  local ALIASESFILE=".zshaliases"
  local ZSHALIASES="${HOMEFOLDER}/.config/.zsh/${ALIASESFILE}"
  local CODE="alias gitui"

  printLine
  printMessage "Installing $NAME"

  if ! command -v bat --version &> /dev/null; then
    brew bundle --file $(require "$FOLDER/Brewfile")
  fi

  if ! grep -q "$CODE" "$ZSHALIASES"; then
    cat $(require "${FOLDER}/${ALIASESFILE}") >> ${ZSHALIASES}
  fi

  printLine
  printSuccess "$NAME successfully installed"
}

