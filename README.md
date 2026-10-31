# dotfiles

Dotfiles for Apple Silicon macOS and Linux x86_64/arm64, managed with
[mise bootstrap](https://mise.jdx.dev/bootstrap.html).

- CLI tools and Node.js are declared in `mise/config.toml` under `[tools]`.
- Git, curl, native dependencies, and macOS apps use mise's built-in Homebrew managers.
- Configuration files link directly to this checkout with mise's `[dotfiles]`.
- zsh plugins use [sheldon](https://github.com/rossmacarthur/sheldon).

![terminal](https://github.com/user-attachments/assets/c2c655a1-d454-4831-b886-29e0d3f21630)

## Setup

Install [mise](https://mise.jdx.dev/getting-started.html) 2026.10.17 or newer.
On macOS, install Apple's Command Line Tools first with `xcode-select --install`.
On Linux, install zsh with your distribution's package manager. Homebrew itself
is optional: mise installs Homebrew packages into `/opt/homebrew` on macOS or
`/home/linuxbrew/.linuxbrew` on Linux, including their runtime dependencies.
Source builds may need your distribution's compiler/build tools.

```sh
# If mise is not already installed:
curl https://mise.run | sh
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/home/linuxbrew/.linuxbrew/bin:$PATH"

git clone https://github.com/KoichiKiyokawa/dotfiles.git ~/dotfiles
cd ~/dotfiles
mise trust ./mise/config.toml
MISE_GLOBAL_CONFIG_FILE="$PWD/mise/config.toml" mise bootstrap --dry-run
MISE_GLOBAL_CONFIG_FILE="$PWD/mise/config.toml" mise bootstrap
exec zsh
```

Keep the checkout at `~/dotfiles`, or make that path a symlink to the checkout.
The configuration sources use this path.
To make zsh your login shell, run `chsh -s "$(command -v zsh)"` separately.

Put machine-specific shell settings in `zsh/local.zsh`.
Bootstrap creates this file if missing and preserves its contents.
On macOS, Flow requires an Apple Account signed into the App Store.
System configuration changes may require sudo.

## Updates and previews

```sh
cd ~/dotfiles
mise bootstrap --dry-run
mise bootstrap --update --upgrade
# Only configuration links, without packages or system tasks:
mise bootstrap --only dotfiles
```

CLI tools use `latest`; Node.js uses `lts`. `--upgrade` updates installed versions.
Update mise with its installer or package manager, and pull repository changes
with `git pull`.

### Battery charge limit

To extend battery lifespan, set the macOS Charge Limit to 80% manually:

1. Open System Settings.
1. Go to Battery.
1. Click the info button next to Charging.
1. Set Charge Limit to 80%.

This setting is applied manually and is not part of bootstrap.

### Superpowers

[Superpowers](https://github.com/obra/superpowers) is installed manually. See the repository for per-agent installation instructions.
