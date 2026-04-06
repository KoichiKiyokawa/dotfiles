#!/bin/sh

set -eu

cd "$(dirname "$0")"
export DOTFILES_ROOT="$PWD"

export NIX_CONFIG="experimental-features = nix-command flakes${NIX_CONFIG:+
}${NIX_CONFIG-}"

exec nix run .#switch -- "$@"
