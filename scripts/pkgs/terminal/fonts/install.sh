#!/usr/bin/env bash

set -e

install_fonts () {
  local NAME="Nerd Fonts"
  local FOLDER="pkgs/terminal/fonts"

  printSectionStart "$NAME"

  brew bundle --file "$(require "$FOLDER/Brewfile")"

  printSectionEnd "$NAME successfully configured"
}

