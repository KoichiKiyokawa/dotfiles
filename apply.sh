#!/bin/sh
set -eu
root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
checkout=$(CDPATH= cd -- "$HOME/dotfiles" 2>/dev/null && pwd -P) || {
  echo "Clone this repository into ~/dotfiles before applying it." >&2
  exit 1
}
if [ "$checkout" != "$root" ]; then
  echo "Run ~/dotfiles/apply.sh, or make ~/dotfiles point to this checkout." >&2
  exit 1
fi
case "$(uname -s)" in
  Darwin) prefix=/opt/homebrew ;;
  Linux) prefix=/home/linuxbrew/.linuxbrew ;;
  *) echo "Only Apple Silicon macOS and Linux are supported." >&2; exit 1 ;;
esac
export PATH="$prefix/opt/curl/bin:$prefix/bin:$prefix/sbin:$HOME/.local/bin:$PATH"
if ! command -v mise >/dev/null 2>&1; then
  echo "Install mise first: https://mise.jdx.dev/getting-started.html" >&2
  exit 1
fi
# Use this checkout even before its global config link exists.
export MISE_GLOBAL_CONFIG_FILE="$root/mise/config.toml"
exec mise -C "$HOME" bootstrap "$@"
