# dotfiles
This repository has following configs.
- fish shell (managed plugin by fisher)
- neovim (managed plugin by dein)
- tig

## How to setup
### Arrange config files and initialize
```
cd ~
git clone https://github.com/KoichiKiyokawa/dotfiles.git
sh init.sh
fisher
```

### install dependencies
#### install packages
- git
- git-now
- neovim
- peco
- tig
- the_silver_searcher

```
# (on Mac)
brew install git git-now neovim peco tig the_silver_searcher
```

#### install powerline fonts
```
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh (or open RobotoMono/Roboto\ Mono\ Medium\ for\ Powerline.ttf)
cd ..
rm -rf fonts
```

#### install formatter
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
#### Load setting file
1. Launch iTerm2 and open Preferences.
1. General > Preferences > Check "Load preferences from a custom folder or URL" 
1. Push "Browse" button and set folder to ~/dotfiles/iTerm2
#### Font setting
1. Profiles > Text > Font select box.
1. Select "Roboto Mono Medium for Powerline"
