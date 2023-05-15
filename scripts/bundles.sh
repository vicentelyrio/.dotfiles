#!/usr/bin/env bash

source $(require "pkgs/terminal/install.sh")
source $(require "pkgs/ide/install.sh")
source $(require "pkgs/osx/install.sh")

successMessage() {
  printSuccess "$1 install selected"
}

onInstallMethod() {
  printLine
  printQuestion "Pick a installation method"

  AUTO="Full"
  PROFILE="By Profile"
  CUSTOM="Custom"

  ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " "$AUTO" "$PROFILE" "$CUSTOM")

  case $ACTIONS in
    $AUTO )     successMessage "$ACTIONS"; onInstallFull;;
    $PROFILE )  successMessage "$ACTIONS"; onInstallByProfile;;
    $CUSTOM )   successMessage "$ACTIONS"; onInstallCustom;;
    * ) printError "$ACTIONS";;
  esac
}

onInstallByProfile() {
  printLine
  printQuestion "Select what profile(s) do you want"

  TERMINAL="Terminal stuff only"
  DEVELOPMENT="Development stack"
  DESIGN="Design"
  GAMEDEV="Game Development"
  ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " --no-limit "$TERMINAL" "$DEVELOPMENT" "$GAMEDEV" "$DESIGN")

  case $ACTIONS in
    $TERMINAL )   successMessage "$ACTIONS"; onInstallTerminal;;
    $DEVELOPMENT) successMessage "$ACTIONS"; onInstallDev;;
    $GAMEDEV)     successMessage "$ACTIONS"; onInstallGamedev;;
    $DESIGN)      successMessage "$ACTIONS"; onInstallDesign;;
    * ) printError "aborted";;
  esac
}

onInstallFull () {
  installTerminalPackagesExec
  installIDEsExec
  installOsxStuffExec
}

onInstallTerminal() {
  installTerminalPackagesExec
}

onInstallDev() {
  installTerminalPackagesExec
  installIDEsExec
}

onInstallGamedev() {
  printError "not implemented"
}

onInstallDesign() {
  printError "not implemented"
}

onInstallCustom () {
  installTerminalPackages
  installIDEs
  installOsxStuff
}
