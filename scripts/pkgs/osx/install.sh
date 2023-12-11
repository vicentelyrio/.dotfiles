#!/usr/bin/env bash

set -e

# shellcheck source=/scripts/pkgs/osx/amethyst/install.sh
source "$(require "pkgs/osx/amethyst/install.sh")"

# shellcheck source=/scripts/pkgs/osx/caffeine/install.sh
source "$(require "pkgs/osx/caffeine/install.sh")"

# shellcheck source=/scripts/pkgs/osx/karabiner/install.sh
source "$(require "pkgs/osx/karabiner/install.sh")"

# shellcheck source=/scripts/pkgs/osx/monitorcontrol/install.sh
source "$(require "pkgs/osx/monitorcontrol/install.sh")"

# shellcheck source=/scripts/pkgs/osx/quicklook/install.sh
source "$(require "pkgs/osx/quicklook/install.sh")"

# shellcheck source=/scripts/pkgs/osx/unarchiver/install.sh
source "$(require "pkgs/osx/unarchiver/install.sh")"

installOsxUtilitiesExec () {
  if ! [ "$OS" == "OSX" ]; then
    return
  fi

  local NAME="MacOS Utilities"

  printSection "Installing $NAME"

  install_amethyst
  install_caffeine
  install_karabiner
  install_monitorcontrol
  install_quicklook
  install_unarchiver

  printSection "✓ $NAME successfully installed"
}

installOsxUtilities () {
  printQuestion "MacOS Utilities"

  local ACTIONS

  local AMETHYST="Amethyst (window manager)"
  local CAFFEINE="Caffeine"
  local KARABINER="Karabiner"
  local MONITORCONTROL="Monitor Control"
  local QUICKLOOK="Quicklook"
  local UNARCHIVER="The Unarchiver"

  ACTIONS=$(
    gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " --no-limit \
    "$AMETHYST" \
    "$CAFFEINE" \
    "$KARABINER" \
    "$MONITORCONTROL" \
    "$QUICKLOOK" \
    "$UNARCHIVER" \
  )

  case "$ACTIONS" in
    "$AMETHYST") install_amethyst ;;
    "$CAFFEINE") install_caffeine ;;
    "$KARABINER") install_karabiner ;;
    "$MONITORCONTROL") install_monitorcontrol ;;
    "$QUICKLOOK") install_quicklook ;;
    "$UNARCHIVER") install_unarchiver ;;
  esac
}

