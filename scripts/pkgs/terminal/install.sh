#!/usr/bin/env bash

set -e

# shellcheck source=/scripts/pkgs/terminal/completion/install.sh
source "$(require "pkgs/terminal/completion/install.sh")"
# shellcheck source=/scripts/pkgs/terminal/fonts/install.sh
source "$(require "pkgs/terminal/fonts/install.sh")"
# shellcheck source=/scripts/pkgs/terminal/zsh/install.sh
source "$(require "pkgs/terminal/zsh/install.sh")"
# shellcheck source=/scripts/pkgs/terminal/fzf/install.sh
source "$(require "pkgs/terminal/fzf/install.sh")"
# shellcheck source=/scripts/pkgs/terminal/bat/install.sh
source "$(require "pkgs/terminal/bat/install.sh")"
# shellcheck source=/scripts/pkgs/terminal/tree/install.sh
source "$(require "pkgs/terminal/tree/install.sh")"
# shellcheck source=/scripts/pkgs/terminal/gtop/install.sh
source "$(require "pkgs/terminal/gtop/install.sh")"
# shellcheck source=/scripts/pkgs/terminal/gitui/install.sh
source "$(require "pkgs/terminal/gitui/install.sh")"
# shellcheck source=/scripts/pkgs/terminal/eza/install.sh
source "$(require "pkgs/terminal/eza/install.sh")"
# shellcheck source=/scripts/pkgs/terminal/neofetch/install.sh
source "$(require "pkgs/terminal/neofetch/install.sh")"
# shellcheck source=/scripts/pkgs/terminal/zoxide/install.sh
source "$(require "pkgs/terminal/zoxide/install.sh")"
# shellcheck source=/scripts/pkgs/terminal/ack/install.sh
source "$(require "pkgs/terminal/ack/install.sh")"
# shellcheck source=/scripts/pkgs/terminal/starship/install.sh
source "$(require "pkgs/terminal/starship/install.sh")"
# shellcheck source=/scripts/pkgs/terminal/tmux/install.sh
source "$(require "pkgs/terminal/tmux/install.sh")"

installTerminalPackagesExec () {
  local NAME="Terminal Utilities"

  printSection "Installing $NAME"

  install_zsh
  install_fonts
  install_completion
  install_fzf
  install_bat
  install_tree
  install_gtop
  install_neofetch
  install_zoxide
  install_ack
  install_starship
  install_tmux
  install_eza
  install_gitui

  source_zsh

  printSection "✓ $NAME successfully installed"
}

installTerminalPackages () {
  local NAME="Terminal Utilities"
  printQuestion "Do you want to install $NAME?"

  local YES="Yes"
  local NO="No"
  local ACTIONS

  ACTIONS="$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " "$YES" "$NO")"

  if [ "$ACTIONS" == $YES ]; then
    installTerminalPackagesExec
  fi
}

