#!/usr/bin/env bash

LOGO='
   _| _ |_(_.| _ _ 
. (_|(_)|_| ||(-_) 
'

# Colors
RED='\033[0;31m'
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

onWelcome() {
  # clear;
  # gum spin --spinner dot -- sleep 2
  gum style \
	  --foreground 212 --border-foreground 212 \
	  --align left --margin "1 1" --padding "1 16 1 1" \
	  "${LOGO[@]}"
	echo ""
	sleep 1
}

# Custom messages
# -----------------------------------
printError() {
  printf "\r ${RED}-- [✕] $1${NC}\n"
}

printSuccess() {
  printf "\r ${GREEN}-- [✓] $1${NC}\n"
}

printWarning() {
  printf "\r ${YELLOW}-- [!] $1${NC}\n"
}

printQuestion() {
  printf "\r ${BLUE}-- [?] $1${NC}\n"
}

printMessage() {
  printf "\r ${PURPLE}-- $1${NC}\n"
}

printText() {
  printf "\r ----------------------------------\n"
  printf "\r $1\n"
  printf "\r ----------------------------------\n"
}

printLine() {
  echo ""
}

# Dialog
dialog() {
  while true; do
    read -p "$(printQuestion "$1 (y/n) ")" yn
    case $yn in
      [Yy]* ) printSuccess "yes"; break;;
      [Nn]* ) printError "abort"; exit;;
      * ) printWarning "Please answer yes or no.";;
    esac
  done
}

# Question
question() {
  local LABEL="$1" 
  local PLACEHOLDER="$2"
  
  printQuestion "$LABEL" 
  
  local OPTION=$(gum input --placeholder "$PLACEHOLDER")
  test -n "$OPTION" && printMessage "$OPTION"

  $($3 $OPTION)
}
