#!/usr/bin/env bash

set -e

# shellcheck source=/scripts/pkgs/code/nvm/install.sh
source "$(require "pkgs/code/nvm/install.sh")"

# shellcheck source=/scripts/pkgs/code/postgress/install.sh
source "$(require "pkgs/code/postgress/install.sh")"

installCodeExec () {
  local NAME="Code"

  printSection "Installing $NAME"

  install_nvm
  install_postgress

  printSection "✓ $NAME successfully installed"
}

installCode() {
  printQuestion "Code stuff"

  local ACTIONS

  local NVM="Nvm"
  local POSTGRESS="Postgress"

  ACTIONS=$(
    gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " --no-limit \
    "$NVM" \
    "$POSTGRESS" \
  )

  case "$ACTIONS" in
    "$NVM") install_nvm ;;
    "$POSTGRESS") install_postgress ;;
  esac
}
