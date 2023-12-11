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

  install_ack
  install_bat
  install_completion
  install_eza
  install_fonts
  install_fzf
  install_gitui
  install_gtop
  install_neofetch
  install_starship
  install_tmux
  install_tree
  install_zoxide
  install_zsh

  source_zsh

  printSection "✓ $NAME successfully installed"
}

installTerminalPackages () {
  printQuestion "Terminal Utilities"

  local ACTIONS
  local ACK="Ack (better grep)"
  local BAT="Bat (better cat)"
  local COMPLETION="Bash completion"
  local EZA="EZA (better LS)"
  local FONTS="Fonts"
  local FZF="FZF (Fuzy Finder)"
  local GITUI="Gitui"
  local GTOP="GTop (htop alternative)"
  local NEOFETCH="Neofetch"
  local STARSHIP="Starship"
  local TMUX="Tmux"
  local TREE="Tree"
  local ZOXIDE="Zoxide"
  local ZSH="Zsh"

  ACTIONS=$(
    gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " --no-limit \
    "$ACK" \
    "$BAT" \
    "$COMPLETION" \
    "$EZA" \
    "$FONTS" \
    "$FZF" \
    "$GITUI" \
    "$GTOP" \
    "$NEOFETCH" \
    "$STARSHIP" \
    "$TMUX" \
    "$TREE" \
    "$ZOXIDE" \
    "$ZSH" \
  )

  for element in "${ACTIONS[@]}"; do
    case "${element}" in
      "$ACK") install_ack ;;
      "$BAT") install_bat ;;
      "$COMPLETION") install_completion ;;
      "$EZA") install_eza ;;
      "$FONTS") install_fonts ;;
      "$FZF") install_fzf ;;
      "$GITUI") install_gitui ;;
      "$GTOP") install_gtop ;;
      "$NEOFETCH") install_neofetch ;;
      "$STARSHIP") install_starship ;;
      "$TMUX") install_tmux ;;
      "$TREE") install_tree ;;
      "$ZOXIDE") install_zoxide ;;
      "$ZSH") install_zsh ;;
    esac
  done
}

