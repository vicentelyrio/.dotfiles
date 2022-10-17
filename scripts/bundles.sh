#!/usr/bin/env bash

successMessage() {
  printSuccess "$1 install selected" 
}

nInstallCorePkg() {
  printWarning "Installing core packages"
  brew bundle --file ../.Brewfile.core 
  printSuccess "Core Packages successfully installed"
}

onGitConfig() {
  if [ -z "$(git config --global --get user.email)" ]; then
    printLine
    printQuestion "Git config (leave blank to skip)" 

    NAME=$(gum input --placeholder "Your github username")  
    EMAIL=$(gum input --placeholder "Your github email")  

    test -n "$NAME" && git config --global user.name "$NAME"
    test -n "$EMAIL" && git config --global user.email "$EMAIL" 
  fi
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
    $DOTFILES ) successMessage "$ACTIONS"; onInstallFull;;
    $DEVELOPMENT) successMessage "$ACTIONS"; onInstallByProfile;; 
    $GAMEDEV) successMessage "$ACTIONS"; onInstallCustom;;
    $DESIGN) successMessage "$ACTIONS"; onInstallCustom;;
    * ) printError "aborted";;
  esac
}
