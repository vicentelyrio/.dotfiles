#!/usr/bin/env bash

set -e
source $(require "pkgs/terminal/zsh/install.sh")

installTerminalPackages () {
  local NAME="Terminal Utilities"
  printLine
  printQuestion "Do you want to install $NAME?" 

  local YES="Yes"
  local NO="No"
  
  local ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " "$YES" "$NO") 
 
  if [ $ACTIONS == $YES ]; then
    printLine
    printMessage "Installing $NAME"
    
    install_zsh

    printLine
    printSuccess "$NAME successfully installed"
  fi
}

