#!/usr/bin/env bash

set -e

install_tmux () {
  local NAME="TMUX"
  local FOLDER="pkgs/terminal/tmux"
  local FILE=".tmux.conf"
  local CODE="#tmux"

  printSectionStart "$NAME"

  install_pkg "$NAME" "$FOLDER" "which tmux"
  install_on_zshrc "$CODE" "$FOLDER"
  install_on_zshaliases "$CODE" "$FOLDER"
  install_config_bkp "$FILE" "$FOLDER" "$FILE"
  install_config_bkp ".tmux-session.sh" "$FOLDER" ".config/.zsh/.tmux-session.sh"

  # source tmux and install plugins
  command -v tmux source-file ~/.tmux.conf &> /dev/null
  command -v ~/.tmux/plugins/tpm/bin/install_plugins &> /dev/null

  printSectionEnd "$NAME successfully configured"
}

