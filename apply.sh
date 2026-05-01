#!/bin/sh

set -eu

cd "$(dirname "$0")"

export NIX_CONFIG="experimental-features = nix-command flakes${NIX_CONFIG:+
}${NIX_CONFIG-}"

if ! command -v nix >/dev/null 2>&1; then
  if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
  elif [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
  fi
fi

nix run .#switch -- "$@"

nix-collect-garbage -d

if command -v brew >/dev/null 2>&1; then
  brew cleanup
fi
