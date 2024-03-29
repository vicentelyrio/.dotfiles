#!/usr/bin/env bash

set -e

# shellcheck source=/scripts/pkgs/browsers/brave/install.sh
source "$(require "pkgs/browsers/brave/install.sh")"

# shellcheck source=/scripts/pkgs/browsers/firefox/install.sh
source "$(require "pkgs/browsers/firefox/install.sh")"

# shellcheck source=/scripts/pkgs/browsers/thorium/install.sh
source "$(require "pkgs/browsers/thorium/install.sh")"

installBrowsersExec () {
  local NAME="Browsers"

  printSection "Installing $NAME"

  install_brave
  install_firefox
  install_thorium

  printSection "✓ $NAME successfully installed"
}

installBrowsers() {
  printQuestion "Browsers"

  local ACTIONS

  local BRAVE="Brave"
  local FIREFOX="Firefox"
  local THORIUM="Thorium"

  ACTIONS=$(
    gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " --no-limit \
    "$BRAVE" \
    "$FIREFOX" \
    "$THORIUM" \
  )

  for element in "${ACTIONS[@]}"; do
    case "${element}" in
      "$BRAVE") install_brave ;;
      "$FIREFOX") install_firefox ;;
      "$THORIUM") install_thorium ;;
    esac
  done
}
