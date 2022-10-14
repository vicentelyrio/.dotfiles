#!/usr/bin/env bash

installBrewAndDeps() {
  echo "-- Installing Homebrew and Dependencies for ${uname}"

  # Do something under 32 bits Windows NT platform
  if [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    echo "-- Windows not suportted"

  # Do something under 64 bits Windows NT platform
  elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    echo "-- Windows not suportted"

  # Do something under GNU/Linux platform
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sudo apt update
    sudo apt-get install build-essential procps curl file git -y
  fi

  # install Homebrew for linux/osx
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
  test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
  echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile
  eval "$($(brew --prefix)/bin/brew shellenv)" 
}

# Check for required dependencies 

if ! command -v brew &> /dev/null
then
  echo "------------------------"
  echo "Homebrew cannot be found"
  echo "------------------------"
  while true; do
    read -p "Do you wish to install Homebrew and its dependencies? (You can install it yourself and then run this config again)" yn
    case $yn in
        [Yy]* ) installBrewAndDeps; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
  done
fi

# Install Core Brew Bundle 
brew bundle --file ./.Brewfile.core 

gum style \
	--foreground 212 --border-foreground 212 --border double \
	--align center --width 50 --margin "1 2" --padding "2 4" \
	'Bubble Gum (1¢)' 'So sweet and so fresh!'
