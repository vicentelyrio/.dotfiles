# Source aliases
source ${ZDOTDIR:-${HOME}}/.zshaliases

# ZCOMET - zsh Plugin manager
if [[ ! -f ${ZDOTDIR:-${HOME}}/.config/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.config/.zcomet/bin
fi

source ${ZDOTDIR:-${HOME}}/.config/.zcomet/bin/zcomet.zsh

# Plugins
zcomet load zsh-users/zsh-syntax-highlighting   # syntax highlight
zcomet load zsh-users/zsh-autosuggestions       # suggestions
zcomet load bossjones/boss-git-zsh-plugin       # git completion
zcomet load lukechilds/zsh-nvm                  # nvm utilities
zcomet load wfxr/forgit                         # git gui

# Compile zcomet
zcomet compinit

