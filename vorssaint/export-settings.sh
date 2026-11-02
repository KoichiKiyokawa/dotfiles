#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
target="$root/Vorssaint Settings.plist"

if [[ -n "${VORSSAINT_BIN:-}" ]]; then
  executable="$VORSSAINT_BIN"
elif [[ -x /Applications/Vorssaint.app/Contents/MacOS/Vorssaint ]]; then
  executable="/Applications/Vorssaint.app/Contents/MacOS/Vorssaint"
else
  executable="$HOME/Applications/Vorssaint.app/Contents/MacOS/Vorssaint"
fi

if [[ ! -x "$executable" ]]; then
  printf 'Vorssaint executable not found: %s\n' "$executable" >&2
  exit 1
fi

tmp="$(mktemp "$target.tmp.XXXXXXXX")"
trap 'rm -f "$tmp"' EXIT

"$executable" --export-settings "$tmp"
plutil -lint "$tmp" >/dev/null
plutil -extract vorssaintBackupVersion raw "$tmp" >/dev/null
plutil -extract settings json "$tmp" >/dev/null

if [[ -f "$target" ]] && cmp -s "$tmp" "$target"; then
  echo "Vorssaint settings unchanged"
else
  mv "$tmp" "$target"
  echo "Updated $target"
fi
