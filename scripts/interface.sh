#!/usr/bin/env bash

set -e

declare -r LOGO='
   _| _ |_(_.| _ _
. (_|(_)|_| ||(-_)
'

# THEME
# -----------------------------------
declare -r RED='\033[0;31m'
declare -r PURPLE='\033[0;35m'
declare -r GREEN='\033[0;32m'
declare -r YELLOW='\033[0;33m'
declare -r BLUE='\033[0;34m'
declare -r NC='\033[0m'
declare -r CARROT='-'

# Welcome Message
# -----------------------------------
welcome() {
  gum style \
	  --foreground 212 --border-foreground 212 \
	  --align left --margin "1 1" --padding "0 6 0 0" \
	  "${LOGO[@]}"
	sleep 2
}

# Custom messages
# -----------------------------------
printError() {
  printf "\r ${RED}%s [✕] $1${NC}\n" "${CARROT}"
}

printSuccess() {
  printf "\r ${GREEN}%s [✓] $1${NC}\n" "${CARROT}"
}

printWarning() {
  printf "\r ${YELLOW}%s [!] $1${NC}\n" "${CARROT}"
}

printQuestion() {
  printf "\r ${BLUE}%s [?] $1${NC}\n" "${CARROT}"
}

printMessage() {
  printf "\r ${PURPLE}%s $1${NC}\n" "$CARROT"
}

printSection() {
  printLine
  printf "$BLUE ----------------------------------\n"
  printf "$BLUE $1${NC}\n"
  printf "$BLUE ----------------------------------\n"
  printLine
}

printSectionStart() {
  printLine
  printf "$BLUE%s $1$NC\n" "$CARROT"
  printf "$BLUE ----------------------------------\n"
}

printSectionEnd() {
  printf "$BLUE ----------------------------------\n"
  printf "$GREEN%s $1$NC\n" "$CARROT"
  printLine
}

printText() {
  printf "\r ----------------------------------\n"
  printf "\r %s\n" "$1"
  printf "\r ----------------------------------\n"
}

printLine() {
  echo ""
}

# Dialog
# -----------------------------------
dialog() {
  while true; do
    read -pr "$(printQuestion "$1 (y/n) ")" yn
    case $yn in
      [Yy]* ) printSuccess "yes"; break;;
      [Nn]* ) printError "abort"; exit;;
      * ) printWarning "Please answer yes or no.";;
    esac
  done
}

# Question
# -----------------------------------
question() {
  printQuestion "$1"
  local OPTION

  OPTION="$(gum input --placeholder "$2")"
  test -n "$OPTION" && printMessage "$OPTION" && "$($3 "$OPTION")"
}

# -----------------------------------
# INSTALL HELPERS
# -----------------------------------

declare -r HOMEFOLDER=${ZDOTDIR:-${HOME}}

# Install a Package with homebrew
# -----------------------------------
install_pkg () {
  local NAME="$1"
  local FOLDER="$2"
  local COMMAND="$3"

  printMessage "Installing $NAME"

  # Install packages
  if ! command -v eval "$COMMAND" &> /dev/null; then
    brew bundle --file "$(require "$FOLDER/Brewfile")"
    printSuccess "$NAME successfully installed"
  else
    printWarning "$NAME is already installed"
  fi
}

# Install a config file and backup previous config
# -----------------------------------
install_config_bkp () {
  local FILE="$1"
  local FOLDER="$2"
  local DESTFILE="${HOMEFOLDER}/$3"

  if cmp "$(require "$FOLDER/$FILE")" "$DESTFILE"; then
    printWarning "$FILE configuration exists, skipping"
  else
    if [ -f "${DESTFILE}" ]; then
      printWarning "$FILE exists but its different, creating a backup."
      mv "${DESTFILE}" "${DESTFILE}.bkp.dotfiles.${DATENOW}"
    fi

    cp "$(require "${FOLDER}/${FILE}")" "${DESTFILE}"
    printSuccess "$FILE confugured successfully"
  fi
}

# Write code from file to .zshrc
# -----------------------------------
install_on_zshrc () {
  local CODE="$1"
  local FOLDER="$2"
  local FILE=".zshrc"
  local ZSHRC="${HOMEFOLDER}/$FILE"

  if ! grep -q "$CODE" "$ZSHRC"; then
    cat "$(require "$FOLDER/$FILE")" >> "$ZSHRC"
    printSuccess "zshrc successfully configured"
  else
    printWarning "zshrc is already configured"
  fi
}

# Write code from file to .zshaliases
# -----------------------------------
install_on_zshaliases () {
  local CODE="$1"
  local FOLDER="$2"
  local FILE=".zshaliases"
  local ZSHALIASES="${HOMEFOLDER}/.config/.zsh/${FILE}"

  if ! grep -q "$CODE" "$ZSHALIASES"; then
    cat "$(require "$FOLDER/$FILE")" >> "${ZSHALIASES}"
    printSuccess "zshaliases successfully configured"
  else
    printWarning "zshaliases is already configured"
  fi
}

