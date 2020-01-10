# dotfiles
This repository has following configs.
- fish shell
- neovim (managed plugin by dein)

## How to setup
### Arrange config files
```
cd ~
git clone https://github.com/KoichiKiyokawa/dotfiles.git
sh init.sh
fisher
```

### install dependencies
#### install packages
```
# (on Mac)
brew install git neovim the_silver_searcher tig peco
```

#### install powerline fonts
```
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
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
- prompt: `Informative Vcs`
