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

# Restart the shell, or load Nix in the current shell
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# Apply macOS system packages, CLI packages, and dotfiles
sh -c 'chsh -s $(which zsh)'
sh init.sh
exec zsh
```

### What Nix manages

- CLI packages such as `git`, `gh`, `mise`, `neovim`, `pnpm`, `starship`
- macOS apps available in nixpkgs, such as `Ghostty`, `Raycast`, `Visual Studio Code`
- Symlinks for `~/.zshrc`, `~/.gitconfig`, `~/.config/nvim`, `~/.config/lazygit`, VS Code settings
- The checked-in dotfiles are linked through the Nix store for reproducible generations
- `zsh/local.zsh` is created by the switch app and remains a local override file

### Apps not managed yet

- `Docker Desktop`, `Google Japanese Input`, and `Skitch` are not declared because matching nixpkgs packages were not available

### Update packages later

```sh
cd ~/dotfiles
nix --extra-experimental-features 'nix-command flakes' flake update
sh init.sh
```


### Enable Touch ID for `sudo` (macOS)

Run the following commands to create `/etc/pam.d/sudo_local` from the template and enable Touch ID authentication for `sudo`:

```sh
sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local
sudo sed -i '' 's/^#auth/auth/' /etc/pam.d/sudo_local
```

### Raycast setting

1. Launch Raycast and press <kbd>alt</kbd> + <kbd>Space</kbd>, then run with inputting `Import Preferences & Data`.
1. Select the `~/dotfiles/raycast/Raycast.rayconfig`.
