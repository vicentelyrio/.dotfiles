#!/usr/bin/env bash

set -e

source $(require "pkgs/osx/quicklook/install.sh")

installOsxStuff() {
  if ! ([ $OS == "OSX" ]); then
    return
  fi

  local NAME="OSX Stuff"
  printLine
  printQuestion "Do you want to install $NAME?"

  local YES="Yes"
  local NO="No"
  
  local ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " "$YES" "$NO") 
 
  if [ $ACTIONS == $YES ]; then
    printLine
    printMessage "Installing $NAME"
    
    install_quicklook

    printLine
    printSuccess "$NAME successfully installed"
  fi
}

