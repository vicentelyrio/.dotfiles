#!/usr/bin/env bash

# shellcheck source=/scripts/pkgs/terminals/install.sh
source "$(require "pkgs/terminals/install.sh")"
# shellcheck source=/scripts/pkgs/terminal/install.sh
source "$(require "pkgs/terminal/install.sh")"
# shellcheck source=/scripts/pkgs/ide/install.sh
source "$(require "pkgs/ide/install.sh")"
# shellcheck source=/scripts/pkgs/osx/install.sh
source "$(require "pkgs/osx/install.sh")"

successMessage() {
  printSuccess "$1 install selected"
}

onInstallMethod() {
  printSection "Install Method"
  printQuestion "Pick a installation method"

  AUTO="All"
  PROFILE="By Profile"
  CUSTOM="Custom"

  ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " "$AUTO" "$PROFILE" "$CUSTOM")

  case $ACTIONS in
    "$AUTO" )     successMessage "$ACTIONS"; onInstallFull;;
    "$PROFILE" )  successMessage "$ACTIONS"; onInstallByProfile;;
    "$CUSTOM" )   successMessage "$ACTIONS"; onInstallCustom;;
    * ) printError "$ACTIONS";;
  esac
}

onInstallByProfile() {
  printQuestion "Select what profile(s) do you want"

  DEVELOPMENT="Development"
  DESIGN="Design"
  GAMEDEV="Game Development"
  DESIGN3D="3D"
  SYSTEM="($OS) System Utitlities"
  ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " --limit=1 "$DEVELOPMENT" "$GAMEDEV" "$DESIGN" "$DESIGN3D" "$SYSTEM")

  case $ACTIONS in
    "$DEVELOPMENT") successMessage "$ACTIONS"; onInstallDev;;
    "$GAMEDEV")     successMessage "$ACTIONS"; onInstallGamedev;;
    "$DESIGN")      successMessage "$ACTIONS"; onInstallDesign;;
    "$DESIGN3D")    successMessage "$ACTIONS"; onInstall3D;;
    "$SYSTEM")      successMessage "$ACTIONS"; onInstallSystem;;
  esac
}

# FULL INSTALL
onInstallFull () {
  installTerminalsPackagesExec
  installTerminalPackagesExec
  installIDEsExec
  installOsxStuffExec
}

# INSTALL BY SEGMENT

# INSTALL DEV STUFF
onInstallDev () {
  installTerminalsPackagesExec
  installTerminalPackagesExec
  installIDEsExec
}

# INSTALL GAMEDEV STUFF
onInstallGamedev () {
  printError "not implemented"
}

# INSTALL DESIGN STUFF
onInstallDesign () {
  printError "not implemented"
}

# INSTALL 3D STUFF
onInstall3D () {
  printError "not implemented"
}

onInstallSystem () {
  if [ "$OS" == "OSX" ]; then installOsxStuffExec; fi
}

onInstallCustom () {
  installTerminalsPackages
  installTerminalPackages
  installIDEs
  installOsxStuff
}

