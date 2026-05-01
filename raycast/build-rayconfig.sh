#!/usr/bin/env bash

set -euo pipefail

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
settings="$dir/settings.json"
out="$dir/Raycast.rayconfig"

while getopts "o:" opt; do
  case "$opt" in
    o) out="$OPTARG" ;;
    *) echo "usage: $0 [-o output.rayconfig]" >&2; exit 2 ;;
  esac
done

gzip -nc "$settings" > "$out"

echo "Wrote $out"
