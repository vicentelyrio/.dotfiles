#!/usr/bin/env bash

set -e

install_quicklook () {
  local NAME="Quicklook plugins"
  local FOLDER="pkgs/osx/quicklook"

  printSectionStart "$NAME"

  brew bundle --file "$(require "$FOLDER/Brewfile")"

  printSectionEnd "$NAME successfully configured"
}

