#!/usr/bin/env bash

set -e

source $(require "pkgs/ide/nvim/install.sh")

installIDEs() {
  local NAME="IDEs"
  printLine
  printQuestion "Do you want to install $NAME?" 

  local YES="Yes"
  local NO="No"
  
  local ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " "$YES" "$NO") 
 
  if [ $ACTIONS == $YES ]; then
    printLine
    printMessage "Installing $NAME"
    
    install_nvim

    printLine
    printSuccess "$NAME successfully installed"
  fi
}
