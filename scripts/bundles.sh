#!/usr/bin/env bash

# shellcheck source=/scripts/pkgs/3d/install.sh
source "$(require "pkgs/3d/install.sh")"

# shellcheck source=/scripts/pkgs/browsers/install.sh
source "$(require "pkgs/browsers/install.sh")"

# shellcheck source=/scripts/pkgs/ide/install.sh
source "$(require "pkgs/ide/install.sh")"

# shellcheck source=/scripts/pkgs/code/install.sh
source "$(require "pkgs/code/install.sh")"

# shellcheck source=/scripts/pkgs/osx/install.sh
source "$(require "pkgs/osx/install.sh")"

# shellcheck source=/scripts/pkgs/terminals/install.sh
source "$(require "pkgs/terminals/install.sh")"

# shellcheck source=/scripts/pkgs/terminal/install.sh
source "$(require "pkgs/terminal/install.sh")"

# shellcheck source=/scripts/pkgs/utilities/install.sh
source "$(require "pkgs/utilities/install.sh")"

successMessage() {
  printSuccess "$1 install selected"
}

onInstallMethod() {
  printSection "Install Method"
  printQuestion "Pick a installation method"

  AUTO="Full install"
  CUSTOM="Custom install"

  ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " "$AUTO" "$CUSTOM")

  case $ACTIONS in
    "$AUTO" ) successMessage "$ACTIONS"; onInstallFull;;
    "$CUSTOM" ) successMessage "$ACTIONS"; onInstallCustom;;
    * ) printError "$ACTIONS";;
  esac
}

onInstallFull () {
  install3DExec
  installBrowsersExec
  installIDEsExec
  installCodeExec
  installOsxUtilitiesExec
  installTerminalsPackagesExec
  installTerminalPackagesExec
  installUtilitiesExec
}

onInstallCustom () {
  install3D
  installBrowsers
  installIDEs
  installCode
  installOsxUtilities
  installTerminalsPackages
  installTerminalPackages
  installUtilities
}

