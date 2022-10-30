#!/usr/bin/env bash

OS="unkown"

case "$OSTYPE" in
  solaris*) OS="SOLARIS" ;;
  darwin*)  OS="OSX" ;; 
  linux*)   OS="LINUX" ;;
  bsd*)     OS="BSD" ;;
  msys*)    OS="WINDOWS" ;;
  cygwin*)  OS="WINDOWS" ;;
  *)        OS="unknown" ;;
esac

untestedOsWarning() {
  if ! ([ $OS == "OSX" ] || [ $OS == "LINUX" ]); then
    printWarning "Untested System ($OS)"
    printText "This script has only been tested on OS X and Ubuntu. It depends on Homebrew to install some programs which may be specific to one or another platform. Try installing Homebrew following the official doc and perform a custom install to manually select what you want."
    dialog "Do you wish to try it anyway?"
  fi
}

installHomebrew() {
  if [ $OS == "LINUX" ]; then
    printWarning "Installing Linux dependencies"
    sudo apt update
    sudo apt-get install build-essential procps curl file git -y
    printSuccess "Linux dependencies successfully installed"
  fi

  printWarning "Installing Homebrew"
  
  # install Homebrew for linux/osx
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
 
  # source brew
  test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
  test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zshrc
  eval "$($(brew --prefix)/bin/brew shellenv)" 

  printSuccess "Homebrew successfully installed"
}

checkAndInstallDependencies() {
  printWarning "Checking for required dependencies..."

  if ! command -v brew &> /dev/null; then
    echo ""
    printError "Homebrew cannot be found"
    printText "Homebrew is a required dependency, please install to continue"
    dialog "Do you wish to install Homebrew and its dependencies?"
    installHomebrew
  fi

  printSuccess "Homebrew is ready"
}
