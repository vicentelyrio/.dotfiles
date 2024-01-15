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
  printf "\r ${PURPLE}%s \n" "${LOGO}"
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
  printf "$BLUE%s $1${NC}\n"
  printf "$BLUE%s ----------------------------------\n"
}

printSectionEnd() {
  printLine
  printf "$BLUE%s -- $GREEN Done\n"
}

printStep() {
  printLine
  printf "$BLUE %s $1$NC\n" "$CARROT"
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
  test -n "$OPTION" && printMessage "$OPTION" && eval "$($3 "$OPTION")"
}
