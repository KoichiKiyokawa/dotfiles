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

The initial commands select the checkout's config before its global link exists.
After setup, run `mise bootstrap` directly. It installs packages, writes macOS
system files, links dotfiles, installs CLI tools,
and runs the final setup task. sudo may be requested for machine-wide changes.
Normal files at dotfile targets cause a conflict; save or move them before retrying.
Existing symlinks are repointed. `zsh/local.zsh` is created if missing and retains
its contents on later runs. Put machine-specific shell settings there.

On macOS, Flow needs an Apple Account signed into the App Store. Bootstrap installs
`mas` with Homebrew and retries Flow in the final task, so the first setup also works
when `mas` was not available at the packages stage. Casks adopt identical existing
apps rather than replacing them. A differing app can require manual reconciliation.
Linux installs the shared CLI tools, Git, curl, and dotfiles; macOS apps and system
settings are skipped.

## Migrating an existing Nix setup

Commit or save local changes, then use the setup commands above in the existing
`~/dotfiles` checkout. Nix and its running installation stay installed. Do not run
`darwin-rebuild` or Home Manager again after migrating, because they would restore
the old links and services.

Home Manager links in your home directory are replaced by direct checkout links.
On macOS, mise refuses to overwrite system symlinks. Before the first apply,
inspect the following paths with `ls -l` and `readlink`. If they are Nix-managed
links through `/etc/static` or `/nix/store`, move those links aside:

```sh
sudo mv /etc/codex/managed_config.toml /etc/codex/managed_config.toml.before-mise
sudo mv /etc/resolver/ts.net /etc/resolver/ts.net.before-mise
sudo mv /etc/pam.d/sudo_local /etc/pam.d/sudo_local.before-mise
```

Only run the commands for Nix-managed links that exist, and first check that the
backup names are unused. Preserve any local contents before moving them.
The system-file phase then creates regular root-owned files. These are manual
migration steps; bootstrap does not remove or rename existing system links.

Touch ID sudo is declared as `/etc/pam.d/sudo_local`. The configuration owns this
whole file; merge any additional local PAM rules into the declaration before
applying. The MagicDNS resolver is also retained.

Tailscale is installed through Homebrew. Its macOS system daemon is installed
separately with Tailscale's own command. After packages are installed, run:

```sh
sudo /opt/homebrew/bin/tailscaled install-system-daemon
```

This replaces the old daemon with label `com.tailscale.tailscaled` and keeps its
state. Repeat this command after upgrading Tailscale to refresh its daemon binary.
Do this before uninstalling Nix so the old service no longer uses a Nix path.

The final task runs `rtk init -g --codex` and installs the declared App Store apps.

Nix removal is a separate operation after verifying the migrated environment.
Follow the uninstall instructions for the Nix installer used on that machine.
Also review Nix-added shell startup entries and `/etc/static` links before removing
its store. This repository does not delete Nix, old generations, profiles, or data.
An existing Homebrew installation is reused; it is no longer managed by nix-darwin.

## Updates and previews

```sh
cd ~/dotfiles
mise bootstrap --dry-run
mise bootstrap --update --upgrade
# Only configuration links, without packages or system tasks:
mise bootstrap --only dotfiles
```

CLI declarations use `latest`, and Node.js uses `lts`.
They are version requests, not a Nix-style locked snapshot. An ordinary apply
installs missing tools/packages; `--upgrade` updates them within these requests.
Update mise separately with its installer or package manager. `--update` does not
pull this repository; use `git pull` explicitly.

The full dry-run prints hooks and the final task without executing them. It may
fetch package metadata and update mise caches, but does not install software or
write the declared dotfiles/system files. `--only dotfiles` skips system settings.

### Battery charge limit

To extend battery lifespan, set the macOS Charge Limit to 80% manually:

1. Open System Settings.
1. Go to Battery.
1. Click the info button next to Charging.
1. Set Charge Limit to 80%.

This setting is applied manually and is not part of bootstrap.

### Superpowers

[Superpowers](https://github.com/obra/superpowers) is installed manually. See the repository for per-agent installation instructions.

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
