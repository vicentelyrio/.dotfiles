#!/usr/bin/env bash

set -e

install_tmux () {
  local NAME="TMUX"
  local FOLDER="pkgs/terminal/tmux"
  local FILE=".tmux.conf"
  local HOMEFOLDER=${ZDOTDIR:-${HOME}}
  local DESTFILE="${HOMEFOLDER}/${FILE}"
  local ZSHRC=".zshrc"
  local ALIASESFILE=".zshaliases"
  local ZSHALIASES="${HOMEFOLDER}/.config/.zsh/${ALIASESFILE}"
  local CODE="alias tk="
  local CODEZSH="TMUXFOLDER"

  printLine
  printMessage "Installing $NAME"
  
  # Install packages
  if ! command -v which tmux &> /dev/null; then
    brew bundle --file $(require "$FOLDER/Brewfile")
  fi

  # Write package manager installer to .zshrc
  if ! grep -q "$CODEZSH" "${HOMEFOLDER}/${ZSHRC}"; then
    cat $(require "${FOLDER}/${ZSHRC}") >> "${HOMEFOLDER}/${ZSHRC}"
  fi

  # backup config
  if [ -f ${DESTFILE} ]; then
    printMessage "Backup current $FILE"
    mv ${DESTFILE} "${DESTFILE}.dotfiles.bkp.${DATENOW}"
  fi

  # copy config
  cp $(require "${FOLDER}/${FILE}") ${DESTFILE}

  # include aliases
  if ! grep -q "$CODE" "$ZSHALIASES"; then
    cat $(require "${FOLDER}/${ALIASESFILE}") >> ${ZSHALIASES}
  fi

  # tmux source-file ~/.tmux.conf
  # command -v ~/.tmux/plugins/tpm/bin/install_plugins
  
  printLine
  printSuccess "$NAME successfully installed"
}

