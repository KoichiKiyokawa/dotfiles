# dotfiles
This repository has following configs.
- [fish shell](https://github.com/fish-shell/fish-shell) (managed plugin by [fisher](https://github.com/jorgebucaran/fisher))
- [neovim](https://github.com/neovim/neovim) (managed plugin by [vim-plug](https://github.com/junegunn/vim-plug))

![terminal](https://user-images.githubusercontent.com/40315079/73604430-e7f17b00-45d3-11ea-9441-a1461f561844.png)


## How to setup
### Install iTerm2
Download [iTerm2](https://iterm2.com/)
### Install packages
- fish
- git
- neovim
- node
- peco
- lazygit
- the_silver_searcher
- yarn

```
# (on Mac)
brew install fish git lazygit neovim node peco the_silver_searcher yarn
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
fisher
```

### Install language server
```
gem install solargraph
npm i -g typescript vue-language-server
```

### Install nerd fonts
Download [RobotoMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Medium/complete/Roboto%20Mono%20Medium%20Nerd%20Font%20Complete.ttf)

### Install formatter
```
npm install -g js-beautify
gem install rubocop
```

### fish style setting
```
fish_config
```
- colors: `Lava`

### iTerm2 setting
1. Launch iTerm2 and open Preferences.
1. General > Preferences > Check "Load preferences from a custom folder or URL" 
1. Push "Browse" button and set folder to ~/dotfiles/iTerm2
