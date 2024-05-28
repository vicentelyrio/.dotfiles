# .dotfiles

My personal dotfiles.
Uses [Ansible](https://www.ansible.com) to provision MacOS and Arch Linux.

> [!WARNING]
> THIS IS A WIP. Do not use.

### Common Setup
for both MacOS and Arch

#### 3D
- [Blender](https://www.blender.org)
- [Ultimaker Cura](https://ultimaker.com/software/ultimaker-cura)

#### Browsers
- [Brave](https://brave.com)
- [Firefox](https://www.mozilla.org/en-US/firefox/new)

#### IDEs
- [Helix](https://helix-editor.com)
- [Neovim](https://neovim.io) with [my custom config](https://github.com/vicentelyrio/nvim)

#### Terminals
- [Alacritty](https://github.com/alacritty/alacritty)
- [Werzterm](https://wezfurlong.org/wezterm/index.html)

#### Terminal Utilities
- [Ack](https://github.com/samaaron/ack) (better grep)
- [Bat](https://github.com/sharkdp/bat) (better cat)
- [Bash Completion](https://github.com/scop/bash-completion)
- [Delta](https://github.com/dandavision/delta) (better git diff)
- [EZA](https://github.com/eza-community/eza) (better ls)
- [Gitui](https://github.com/extrawurst/gitui) (git tui)
- [Neofetch](https://github.com/dylanaraps/neofetch) (system information)
- [Starship](https://starship.rs/) (shell prompt)
- [Tmux](https://github.com/tmux) (terminal multiplexer)
- [Tree](https://github.com/Old-Man-Programmer/tree) (directory tree view)
- [Zoxide](https://github.com/ajeetdsouza/zoxide) (better cd)
- [Zsh](https://www.zsh.org/) (better shell)

#### Development
- [nvm](https://github.com/nvm-sh/nvm)
- [node](https://nodejs.org)
- [npm](https://www.npmjs.com)
- [yarn](https://yarnpkg.com)
- github ([multiple users](https://github.com/vicentelyrio/.dotfiles/provision/vars/all.yml) setup)

#### Utilities Apps
- [Obsidian](https://obsidian.md)
- [QMK](https://qmk.fm)
- [Slack](https://slack.com)
- [Spotify](https://www.spotify.com)
- [VIA](https://www.caniusevia.com)

### Macos exclusive
- [Karabiner](https://karabiner-elements.pqrs.org/)
- [Monitor Control](https://github.com/MonitorControl/MonitorControl)
- [Quicklook plugins](https://www.quicklookplugins.com/) (not all)
- [The Unarchiver](https://theunarchiver.mom/)

### Arch setup
Update the [vars](https://github.com/vicentelyrio/.dotfiles/provision/vars/all.yml) file with custom configurations

##### System
- User setup
- Pacman setup
- Reflector setup
- Yay setup
- Cronie setup
- CPU setup
- GPU setup
- Npt setup
- Locale setup
- SSH agent setup
- Bluetooth setup
- Network setup
- Audio setup
- RKHunter setup
- Grub setup
- Greet setup
- Pacseek

##### Interface
- Centralized Theme config
- Fonts
- Font Manager
- Hyprland
- Hyprpaper
- Hypridle
- Hyprlock


##### References/inspirations
- https://github.com/id101010/ansible-archlinux (ansible)
- https://github.com/snowiow/snow (ansible)
- https://github.com/Matt-FTW/dotfiles (ansible/hyprland)

> [!IMPORTANT]
> TODO:
> - Review permissions management for arch roles
> - Review error handling
> - Review macos install for common roles
> - Github-cli authentication via prompt
> - Grub setup
> - Greet setup
> - Virt-manager setup
> - udisk setup
> - OSD
> - Notification
> - Bar
> - Launcher
> - Clipboard
> - Screen capture
> - Screen share
> - Multimidia
> - GTK theme
> - QT theme
> - Electron apps themes for wayland
> - hy3
> - hyprwinwrap
