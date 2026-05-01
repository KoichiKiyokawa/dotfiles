# dotfiles

This repository contains my macOS dotfiles and Nix-based system setup.

- zsh configuration, with plugins managed by [sheldon](https://github.com/rossmacarthur/sheldon)
- [Neovim](https://github.com/neovim/neovim) configuration, with plugins managed by [packer.nvim](https://github.com/wbthomason/packer.nvim)
- macOS system settings, packages, apps, and dotfile links managed with Nix, nix-darwin, and home-manager

![terminal](https://github.com/user-attachments/assets/c2c655a1-d454-4831-b886-29e0d3f21630)

## Setup

### Clone and apply the configuration

```sh
cd ~
git clone https://github.com/KoichiKiyokawa/dotfiles.git
cd dotfiles

# Install Nix first
sh <(curl -L https://nixos.org/nix/install) --daemon

# Restart the shell, or load Nix in the current shell
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# Apply macOS system packages, CLI packages, and dotfiles
sh -c 'chsh -s $(which zsh)'
sh apply.sh
exec zsh
```

### What Nix manages

- CLI packages such as `git`, `gh`, `mise`, `neovim`, `pnpm`, `starship`
- macOS apps available in nixpkgs, such as `Ghostty`, `Raycast`, `Visual Studio Code`
- Homebrew Cask apps such as `Docker Desktop`, `Google Japanese Input`
- Mac App Store apps such as `Skitch`
- Symlinks for `~/.zshrc`, `~/.gitconfig`, `~/.config/nvim`, `~/.config/lazygit`, VS Code settings
- The checked-in dotfiles are linked through the Nix store for reproducible generations
- `zsh/local.zsh` is created by the switch app and remains a local override file
- Touch ID authentication for `sudo` on macOS

### Homebrew apps

`Docker Desktop` and `Google Japanese Input` are declared through nix-darwin's Homebrew Cask integration. `Skitch` is declared through nix-darwin's Mac App Store integration. Homebrew itself is installed by the flake through `nix-homebrew`.

### Update packages later

```sh
cd ~/dotfiles
nix --extra-experimental-features 'nix-command flakes' flake update
sh apply.sh
```

### Raycast setting

1. Launch Raycast and press <kbd>alt</kbd> + <kbd>Space</kbd>, then run `Import Preferences & Data`.
1. Select the `~/dotfiles/raycast/Raycast.rayconfig`.
