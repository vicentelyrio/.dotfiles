#!/usr/bin/env bash

set -e

install_completion () {
  local NAME="Bash Completion"
  local FOLDER="pkgs/terminal/completion"
  local BASHPROFILE="${HOMEFOLDER}/.bash_profile"
  local CODE="[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion"

  printSectionStart "$NAME"

  printMessage "Installing $NAME"

  if ! grep -q "$CODE" "$BASHPROFILE"; then
    brew bundle --file "$(require "$FOLDER/Brewfile")"
    echo "eval \"$CODE"\" >> "$BASHPROFILE"
    printSuccess "$NAME installed"
  else
    printMessage "$NAME already installed"
  fi

  printSectionEnd "$NAME successfully configured"
}

