# dotfiles

This repository has following configs.

- zsh (managed plugin by [sheldon](https://github.com/rossmacarthur/sheldon))
- [neovim](https://github.com/neovim/neovim) (managed plugin by [packer.nvim](https://github.com/wbthomason/packer.nvim))

![terminal](https://user-images.githubusercontent.com/40315079/169636800-608490e9-3780-4b43-bfbc-8f31259f2720.png)

## How to setup

### Arrange config files and initialize

```
cd ~
git clone https://github.com/KoichiKiyokawa/dotfiles.git
cd dotfiles
# (on Mac)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle
sh -c 'chsh -s $(which zsh)'
sh init.sh
exec zsh
```

### iTerm2 setting

1. Launch iTerm2 and open Preferences.
1. General > Preferences > Check "Load preferences from a custom folder or URL"
1. Push "Browse" button and set folder to ~/dotfiles/iTerm2

### Raycast setting

1. Launch Raycast and press <kbd>alt</kbd> + <kbd>Space</kbd>, then run with inputting `Import Preferences & Data`.
1. Select the `~/dotfiles/Raycast.rayconfig`.
