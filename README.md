# dotfiles

This repository has following configs.

- zsh (managed plugin by [sheldon](https://github.com/rossmacarthur/sheldon))
- [neovim](https://github.com/neovim/neovim) (managed plugin by [packer.nvim](https://github.com/wbthomason/packer.nvim))

![terminal](https://github.com/user-attachments/assets/c2c655a1-d454-4831-b886-29e0d3f21630)

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

1. Launch iTerm2 and open Preferences(<kbd>⌘</kbd> + <kbd>,</kbd>).
1. General > Settings > Check "Load preferences from a custom folder or URL" and type "~/dotfiles/iTerm2".
1. Select "Save Changes" Option to `Manually`.

<img width="897" alt="image" src="https://github.com/user-attachments/assets/ccdf660d-c9fc-479e-9930-69e9ffa46d4d" />

### Raycast setting

1. Launch Raycast and press <kbd>alt</kbd> + <kbd>Space</kbd>, then run with inputting `Import Preferences & Data`.
1. Select the `~/dotfiles/Raycast.rayconfig`.
