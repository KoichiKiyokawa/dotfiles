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

# Apply macOS system packages, CLI packages, and dotfiles
sh -c 'chsh -s $(which zsh)'
./apply.sh
exec zsh
```

### What Nix manages

- CLI packages such as `git`, `gh`, `mise`, `neovim`, `pnpm`, `starship`
- macOS apps available in nixpkgs, such as `Ghostty`, `Raycast`, `Visual Studio Code`
- Homebrew Cask apps such as `Codex`, `Docker Desktop`, `Google Japanese Input`
- Mac App Store apps such as `Skitch`
- Symlinks for `~/.zshrc`, `~/.gitconfig`, `~/.config/nvim`, `~/.config/lazygit`, `~/.config/mise/config.toml`, VS Code settings
- The checked-in dotfiles are linked through the Nix store for reproducible generations
- `zsh/local.zsh` is created by the switch app and remains a local override file
- Touch ID authentication for `sudo` on macOS

### Homebrew apps

`Codex`, `Docker Desktop`, and `Google Japanese Input` are declared through nix-darwin's Homebrew Cask integration. `Skitch` is declared through nix-darwin's Mac App Store integration. Homebrew itself is installed by the flake through `nix-homebrew`.

### Battery charge limit

To extend battery lifespan, set the macOS Charge Limit to 80% manually:

1. Open System Settings.
1. Go to Battery.
1. Click the info button next to Charging.
1. Set Charge Limit to 80%.

This is not managed by nix-darwin. macOS Tahoe 26.4 added the standard Charge Limit setting, but nix-darwin does not currently expose a stable option for it, and the setting does not appear in `pmset` or the usual `defaults` domains.

### Update packages later

```sh
cd ~/dotfiles
nix --extra-experimental-features 'nix-command flakes' flake update
./apply.sh
```

### Raycast

Raycast is managed with text files only. Generated `.rayconfig` files are ignored by git.

- `raycast/settings.json`: script command directories, command hotkeys, and snippets
- `raycast/scripts`: script commands

Build an import file:

```sh
cd ~/dotfiles
raycast/build-rayconfig.sh
```

Then import it:

1. In Raycast, run `Import Settings & Data`.
1. Select `~/dotfiles/raycast/Raycast.rayconfig`.
1. Import the selected data.

The generated `.rayconfig` is `raycast/settings.json` compressed with gzip. This import format is reverse-engineered. If Raycast stops accepting it, keep `raycast/settings.json` as the source of truth and apply the entries manually through Raycast Settings.
