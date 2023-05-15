#!/usr/bin/env bash

set -e

source $(require "pkgs/terminal/completion/install.sh")
source $(require "pkgs/terminal/fonts/install.sh")
source $(require "pkgs/terminal/zsh/install.sh")
source $(require "pkgs/terminal/fzf/install.sh")
source $(require "pkgs/terminal/bat/install.sh")
source $(require "pkgs/terminal/tree/install.sh")
source $(require "pkgs/terminal/gtop/install.sh")
source $(require "pkgs/terminal/neofetch/install.sh")
source $(require "pkgs/terminal/zoxide/install.sh")
source $(require "pkgs/terminal/ack/install.sh")
source $(require "pkgs/terminal/starship/install.sh")
source $(require "pkgs/terminal/tmux/install.sh")

TERMINAL_NAME="Terminal Utilities"

installTerminalPackagesExec () {
  printLine
  printMessage "Installing $TERMINAL_NAME"

  install_fonts
  install_completion
  install_zsh
  install_fzf
  install_bat
  install_tree
  install_gtop
  install_neofetch
  install_zoxide
  install_ack
  install_starship
  install_tmux

  source_zsh

  printLine
  printSuccess "$TERMINAL_NAME successfully installed"
}

installTerminalPackages () {
  printLine
  printQuestion "Do you want to install $TERMINAL_NAME?"

  local YES="Yes"
  local NO="No"

  local ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " "$YES" "$NO")

  if [ $ACTIONS == $YES ]; then
    installTerminalPackagesExec
  fi
}

