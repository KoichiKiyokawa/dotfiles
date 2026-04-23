# dotfiles

This repository has following configs.

- zsh (managed plugin by [sheldon](https://github.com/rossmacarthur/sheldon))
- [neovim](https://github.com/neovim/neovim) (managed plugin by [packer.nvim](https://github.com/wbthomason/packer.nvim))

![terminal](https://github.com/user-attachments/assets/c2c655a1-d454-4831-b886-29e0d3f21630)

## How to setup

### Arrange config files and initialize

```sh
cd ~
git clone https://github.com/KoichiKiyokawa/dotfiles.git
cd dotfiles

# Install Devbox first
curl -fsSL https://get.jetify.com/devbox | bash

# Apply packages and dotfiles
sh -c 'chsh -s $(which zsh)'
sh init.sh
exec zsh
```

### What Devbox manages

- CLI packages such as `git`, `gh`, `mise`, `neovim`, `starship`
- Shell environment for this dotfiles setup via `devbox shellenv`
- Dotfile symlinks for zsh, neovim, lazygit, VS Code settings
- GUI apps such as VS Code, Docker Desktop, Raycast, and iTerm2 are still installed separately

### Update packages later

```sh
cd ~/dotfiles
devbox update
exec zsh
```

### Add a package

Search for the package in Devbox, add it with `devbox add`, then apply the change.

```sh
cd ~/dotfiles
PACKAGE=just
devbox search "$PACKAGE"

devbox add "$PACKAGE"

exec zsh
```

### Raycast setting

1. Launch Raycast and press <kbd>alt</kbd> + <kbd>Space</kbd>, then run with inputting `Import Preferences & Data`.
1. Select the `~/dotfiles/raycast/Raycast.rayconfig`.
