#!/usr/bin/env bash

set -e

source $(require "pkgs/terminal/zsh/install.sh")
source $(require "pkgs/terminal/fzf/install.sh")
source $(require "pkgs/terminal/bat/install.sh")
source $(require "pkgs/terminal/tree/install.sh")
source $(require "pkgs/terminal/gtop/install.sh")
source $(require "pkgs/terminal/neofetch/install.sh")
source $(require "pkgs/terminal/zoxide/install.sh")

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
    install_fzf
    install_bat
    install_tree
    install_gtop
    install_neofetch
    install_zoxide

    printLine
    printSuccess "$NAME successfully installed"
  fi
}

