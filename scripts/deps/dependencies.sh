#!/usr/bin/env bash

# Warns user about unsuported systems
untestedOsWarning() {
  if [ "$OS" == "OSX" ]; then return; fi

  if [ "$OS" == "LINUX" ]; then return; fi

  printLine
  printWarning "Untested System ($OS)"
  printText "This script has only been tested on OS X and some Linux distributions. It depends on Homebrew to install some programs which may be specific to one or another platform. Try installing Homebrew following the official doc."
  dialog "Do you wish to try it anyway?"
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

  packagesNeeded='build-essential procps curl file git'

  if [ -x "$(command -v apk)" ];       then sudo apk add --no-cache $packagesNeeded
  elif [ -x "$(command -v apt-get)" ]; then sudo apt-get install $packagesNeeded
  elif [ -x "$(command -v dnf)" ];     then sudo dnf install $packagesNeeded
  elif [ -x "$(command -v zypper)" ];  then sudo zypper install $packagesNeeded
  else
    printError "Package manager not found. You must manually install: $packagesNeeded">&2;
    return;
  fi

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
  if [ "$OS" == "OSX" ]; then
    echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zprofile
    eval "$("$(brew --prefix)"/bin/brew shellenv)"
  fi

  if [ "$OS" == "LINUX" ]; then
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/vicentelyrio/.zshrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
}

# Install Steps
installHomebrew() {
  if [ "$OS" == "OSX" ]; then
    installOsxDeps
    installBrew
    sourceBrewZsh
  fi
  if [ "$OS" == "LINUX" ]; then
    installLinuxDeps
    installBrew
    sourceBrewLinux
    sourceBrewZsh
  fi
}

# Check for dependencies and ask for install permission
installDependencies() {
  printSection "Dependencies check"

  if ! command -v brew &> /dev/null; then
    printLine
    printError "Homebrew cannot be found"
    printText "Homebrew is a required dependency, please install to continue"
    dialog "Do you wish to install Homebrew and its dependencies?"
    installHomebrew
  fi

  printSuccess "All dependencies installed"
}
