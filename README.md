# dotfiles

This repository has following configs.

- [fish shell](https://github.com/fish-shell/fish-shell) (managed plugin by [fisher](https://github.com/jorgebucaran/fisher))
- [neovim](https://github.com/neovim/neovim) (managed plugin by [vim-plug](https://github.com/junegunn/vim-plug))

![terminal](https://user-images.githubusercontent.com/40315079/73604430-e7f17b00-45d3-11ea-9441-a1461f561844.png)

## How to setup

### Install packages

- fish
- git
- neovim
- peco
- lazygit
- iTerm2
- gh (GitHub CLI)
- Karabiner Elements
- VSCode

```
# (on Mac)
brew install fish git lazygit neovim peco iterm2 gh karabiner-elements visual-studio-code

sudo sh -c 'echo $(which fish) >> /etc/shells'
sh -c 'chsh -s $(which fish)'
```

Then relaunch your terminal.

### Setup node version manager

```
curl https://get.volta.sh | bash
```

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
