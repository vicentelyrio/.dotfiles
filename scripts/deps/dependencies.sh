#!/usr/bin/env bash

# Warns user about unsuported systems
untestedOsWarning() {
  if ! [ "$OS" == "OSX" ] || [ "$OS" == "LINUX" ]; then
    printLine
    printWarning "Untested System ($OS)"
    printText "This script has only been tested on OS X and Ubuntu. It depends on Homebrew to install some programs which may be specific to one or another platform. Try installing Homebrew following the official doc and perform a custom install to manually select what you want."
    dialog "Do you wish to try it anyway?"
  fi
}

# Install OSX Deps
installOsxDeps() {
  if ! command -v xcode-select --version &> /dev/null; then
    printLine
    printMessage "Installing OSX dependencies"
    xcode-select --install
    printSuccess "OSX dependencies successfully installed"
  fi
}

#Install Linux Deps
installLinuxDeps() {
  printLine
  printMessage "Installing Linux dependencies"

  sudo apt update
  sudo apt-get install build-essential procps curl file git -y

  printSuccess "Linux dependencies successfully installed"
}

# Install Brew
installBrew() {
  printLine
  printMessage "Installing Homebrew"

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  printSuccess "Homebrew successfully installed"
}

# Source Brew with Linux
sourceBrewLinux() {
  test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
  test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
  echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile
}

# source Brew with ZSH
sourceBrewZsh() {
  echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zprofile
  eval "$("$(brew --prefix)"/bin/brew shellenv)"
}

# Install Steps
installHomebrew() {
  if [ "$OS" == "OSX" ]; then
    installOsxDeps
    installBrew
    sourceBrewZsh
  else
    installLinuxDeps
    installBrew
    sourceBrewLinux
    sourceBrewZsh
  fi
}

# Check for dependencies and ask for install permission
installDependencies() {
  printSection "Dependencies check"
  gum spin --spinner minidot --title "Checking for required dependencies..." -- sleep 1

  if ! command -v brew &> /dev/null; then
    printLine
    printError "Homebrew cannot be found"
    printText "Homebrew is a required dependency, please install to continue"
    dialog "Do you wish to install Homebrew and its dependencies?"
    installHomebrew
  fi

  printSuccess "All dependencies installed"
}
