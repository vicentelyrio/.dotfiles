#!/usr/bin/env bash

successMessage() {
  printSuccess "$1 install selected"
}

onInstallMethod() {
  printLine
  printQuestion "Select what installation method do you want"

  AUTO="Auto"
  PROFILE="Profile"
  CUSTOM="Custom"

  ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " "$AUTO" "$PROFILE" "$CUSTOM")

  case $ACTIONS in
    $AUTO ) successMessage "$ACTIONS"; onInstallFull;;
    $PROFILE ) successMessage "$ACTIONS"; onInstallByProfile;;
    $CUSTOM ) successMessage "$ACTIONS"; onInstallCustom;;
    * ) printError "$ACTIONS";;
  esac
}

onInstallByProfile() {
  printLine
  printQuestion "Select what profile(s) do you want"

  DOTFILES="Dotfiles only"
  DEVELOPMENT="Development stack"
  DESIGN="Design"
  GAMEDEV="Game Development"
  ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " --no-limit "$DOTFILES" "$DEVELOPMENT" "$GAMEDEV" "$DESIGN")

  case $ACTIONS in
    $DOTFILES ) successMessage "$ACTIONS"; onInstallDotfiles;;
    $DEVELOPMENT) successMessage "$ACTIONS"; onInstallByProfile;;
    $GAMEDEV) successMessage "$ACTIONS"; onInstallCustom;;
    $DESIGN) successMessage "$ACTIONS"; onInstallCustom;;
    * ) printError "aborted";;
  esac
}

# onInstallDotfiles() {
#   printWarning "Installing Terminal Utilities"
#   brew bundle --file ./.Brewfile.terminal
#   $(brew --prefix)/opt/fzf/install
#   printSuccess "Terminal Utilities successfully installed"
# }
