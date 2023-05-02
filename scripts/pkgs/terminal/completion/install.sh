#!/usr/bin/env bash

set -e

install_completion () {
  local NAME="Bash Completion"
  local FOLDER="pkgs/terminal/completion"
  local HOMEFOLDER=${ZDOTDIR:-${HOME}}
  local BASHPROFILE="${HOMEFOLDER}/.bash_profile"
  local CODE="[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion"

  printLine
  printMessage "Installing $NAME"

  # install
  if ! grep -q "$CODE" "$BASHPROFILE"; then
    brew bundle --file $(require "$FOLDER/Brewfile")
    echo "eval \"$CODE"\" >> "$BASHPROFILE"
  fi

  printLine
  printSuccess "$NAME successfully installed"
}

