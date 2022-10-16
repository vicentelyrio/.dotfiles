#!/usr/bin/env bash

onInstallCorePkg() {
  printWarning "Installing core packages"
  brew bundle --file ../.Brewfile.core 
  printSuccess "Core Packages successfully installed"
}

onInstallByType() {
  printQuestion "Select what installation method do you want"; sleep 1

  AUTO="Auto (will install everthing for your OS)";
  PROFILE="Profile (select based on predefined profiles)";
  CUSTOM="Custom (select what you want)"
  
  ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " "$AUTO" "$PROFILE" "$CUSTOM") 
  
  case $ACTIONS in
    $AUTO ) onInstallFull;;
    $PROFILE ) onInstallByProfile;; 
    $CUSTOM ) onInstallCustom;;
  esac
}

onInstallByProfile() {
  printQuestion "Select what profile(s) do you want"; sleep 1

  DEVELOPMENT="Development"; DESIGN="Design"; GAMEDEV="Game Development"
  ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " --no-limit "$DEVELOPMENT" "$GAMEDEV" "$DESIGN")
}
