# dotfiles

This repository has following configs.

- [fish shell](https://github.com/fish-shell/fish-shell) (managed plugin by [fisher](https://github.com/jorgebucaran/fisher))
- [neovim](https://github.com/neovim/neovim) (managed plugin by [vim-plug](https://github.com/junegunn/vim-plug))

![terminal](https://user-images.githubusercontent.com/40315079/169636800-608490e9-3780-4b43-bfbc-8f31259f2720.png)



## How to setup

### Install packages

- fish
- git
- neovim
- peco
- lazygit
- iTerm2
- gh (GitHub CLI)
- [fnm](https://github.com/Schniz/fnm)
- Karabiner Elements
- Docker Desktop
- VSCode
- Skitch
- Clipy
- [Aldente](https://github.com/davidwernhart/AlDente)
- [Kap](https://getkap.co/)

```
# (on Mac)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install fish git lazygit neovim peco gh fnm
brew install --cask iterm2 karabiner-elements docker visual-studio-code skitch clipy aldente kap p4v

sudo sh -c 'echo $(which fish) >> /etc/shells'
sh -c 'chsh -s $(which fish)'
```

Then relaunch your terminal.

### Arrange config files and initialize

```
cd ~
git clone https://github.com/KoichiKiyokawa/dotfiles.git
cd dotfiles
sh init.sh
fisher install (cat fish/fishfile)
```

### Install nerd fonts

Download [RobotoMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Medium/complete/Roboto%20Mono%20Medium%20Nerd%20Font%20Complete.ttf)

### fish style setting

```
fish_config
```

- colors: `Lava`

### iTerm2 setting

1. Launch iTerm2 and open Preferences.
1. General > Preferences > Check "Load preferences from a custom folder or URL"
1. Push "Browse" button and set folder to ~/dotfiles/iTerm2

### Install formatter

```
npm install -g js-beautify
gem install rubocop
```

### Install language server

```
gem install solargraph
npm i -g typescript vue-language-server
```
