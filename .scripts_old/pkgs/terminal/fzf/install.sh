#!/usr/bin/env bash

set -e

install_fzf () {
  local NAME="FZF"
  local FOLDER="pkgs/terminal/fzf"
  local FILE=".fzf.zsh"
  local DESTFILE="${HOMEFOLDER}/${FILE}"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "fzf --version"

  install_on_zshrc "#fzf" "$FOLDER"

  # install autocompletion
  gum spin --spinner minidot --title "Checking for required dependencies..." -- "$(brew --prefix)"/opt/fzf/install --all --no-bash

  # install theme
  cat "$(require "${FOLDER}/${FILE}")" >> "${DESTFILE}"

  printSectionEnd "$NAME successfully configured"
}

