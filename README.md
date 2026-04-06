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

# Install Nix first
sh <(curl -L https://nixos.org/nix/install) --daemon

# Apply packages and dotfiles
sh -c 'chsh -s $(which zsh)'
sh init.sh
exec zsh
```

### What Nix manages

- CLI packages such as `git`, `gh`, `mise`, `neovim`, `starship`
- Symlinks for `~/.zshrc`, `~/.gitconfig`, `~/.config/nvim`, `~/.config/lazygit`, VS Code settings
- `zsh/local.zsh` is kept as a local override file outside of Nix-managed config content

### Update packages later

```sh
cd ~/dotfiles
nix --extra-experimental-features 'nix-command flakes' flake update
sh init.sh
```

### Raycast setting

1. Launch Raycast and press <kbd>alt</kbd> + <kbd>Space</kbd>, then run with inputting `Import Preferences & Data`.
1. Select the `~/dotfiles/raycast/Raycast.rayconfig`.
