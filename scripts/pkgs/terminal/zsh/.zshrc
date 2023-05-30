# Source aliases
source ${ZDOTDIR:-${HOME}}/.config/.zsh/.zshaliases

# zsh highlight theme
if [[ ! -f ${ZDOTDIR:-${HOME}}/.config/.zsh/zsh-sh-theme/.catppuccin.yaml ]]; then
  command git clone https://github.com/catppuccin/zsh-syntax-highlighting.git ${ZDOTDIR:-${HOME}}/.config/.zsh/zsh-sh-theme
fi

source ${ZDOTDIR:-${HOME}}/.config/.zsh/zsh-sh-theme/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

# zsh nvm config
export NVM_COMPLETION=true
export NVM_AUTO_USE=true

# ZCOMET - plugin manager
if [[ ! -f ${ZDOTDIR:-${HOME}}/.config/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.config/.zcomet/bin
fi

source ${ZDOTDIR:-${HOME}}/.config/.zcomet/bin/zcomet.zsh

# Plugins
zcomet load lukechilds/zsh-nvm                                                  # nvm utilities
zcomet load zpm-zsh/ls                                                          # better ls
zcomet load ohmyzsh plugins/gitfast                                             # completion

zcomet load zsh-users/zsh-completions                                           # tab completion
zcomet load zsh-users/zsh-history-substring-search                              # history (with up arrow)
zcomet load zsh-users/zsh-autosuggestions                                       # suggestions
zcomet load zsh-users/zsh-syntax-highlighting                                   # syntax highlight

# Compile zcomet
zcomet compinit

# Auto-generated code

