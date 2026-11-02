# dotfiles

Dotfiles for Apple Silicon macOS and Linux x86_64/arm64, managed with
[mise bootstrap](https://mise.jdx.dev/bootstrap.html).

- CLI tools and Node.js are declared in `mise/config.toml` under `[tools]`.
- Git, curl, native dependencies, and macOS apps use mise's built-in Homebrew managers.
- Configuration files link directly to this checkout with mise's `[dotfiles]`.
- zsh plugins use [sheldon](https://github.com/rossmacarthur/sheldon).

![terminal](https://github.com/user-attachments/assets/c2c655a1-d454-4831-b886-29e0d3f21630)

## Setup

The committed `bin/mise` script downloads mise 2026.10.17 on first use. An
existing mise installation is not required. Git, Bash, curl, tar, and a SHA-256
checksum utility must be available before running it. On macOS, install Apple's
Command Line Tools first with `xcode-select --install`. On Linux, install zsh
with your distribution's package manager. Homebrew itself is optional: mise
installs Homebrew packages into `/opt/homebrew` on macOS or
`/home/linuxbrew/.linuxbrew` on Linux, including their runtime dependencies.
Source builds may need your distribution's compiler/build tools.

```sh
git clone https://github.com/KoichiKiyokawa/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bin/mise trust ./mise/config.toml
MISE_GLOBAL_CONFIG_FILE="$PWD/mise/config.toml" ./bin/mise bootstrap --dry-run
MISE_GLOBAL_CONFIG_FILE="$PWD/mise/config.toml" ./bin/mise bootstrap
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
# Only macOS apps managed by brew-cask:
mise bootstrap packages upgrade --manager brew-cask
# Only configuration links, without packages or system tasks:
mise bootstrap --only dotfiles
```

CLI tools use `latest`; Node.js uses `lts`. `--upgrade` updates installed versions.
Plain `mise bootstrap` installs missing packages but does not upgrade installed apps.
Close self-updating apps before upgrading them. Run upgrades in an interactive
terminal so mise can prompt for sudo when required.

The generated wrapper pins mise 2026.10.17 and is placed on `PATH` by
`zsh/.zshrc`. To change the pinned mise version, regenerate and commit it:

```sh
mise generate install-script --write ./bin/mise
```

Pull repository changes with `git pull`. The next wrapper invocation downloads
the newly pinned release if it is not already installed.

### Vorssaint settings

[Vorssaint Settings.plist](<Vorssaint Settings.plist>) is a tracked XML settings backup.
`mise bootstrap` imports it on macOS after installing apps. Quit Vorssaint
before bootstrapping; its CLI rejects imports while the app is running.
To export the current settings, run `mise run vorssaint:export`.

### Battery charge limit

To extend battery lifespan, set the macOS Charge Limit to 80% manually:

1. Open System Settings.
1. Go to Battery.
1. Click the info button next to Charging.
1. Set Charge Limit to 80%.

This setting is applied manually and is not part of bootstrap.

### Superpowers

[Superpowers](https://github.com/obra/superpowers) is installed manually. See the repository for per-agent installation instructions.
