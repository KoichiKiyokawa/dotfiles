#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != Darwin ]]; then
  echo "Vorssaint settings import requires macOS" >&2
  exit 1
fi

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
settings="$root/Vorssaint Settings.plist"

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

plutil -lint "$settings" >/dev/null
plutil -extract vorssaintBackupVersion raw "$settings" >/dev/null
plutil -extract settings json "$settings" >/dev/null

was_running=false
if pgrep -x Vorssaint >/dev/null; then
  was_running=true
  osascript -e 'tell application id "com.vorssaint.utils" to quit'
  for ((i = 0; i < 50; i++)); do
    if ! pgrep -x Vorssaint >/dev/null; then
      break
    fi
    sleep 0.2
  done
  if pgrep -x Vorssaint >/dev/null; then
    echo "Vorssaint did not exit; settings not imported" >&2
    exit 1
  fi
fi

"$executable" --import-settings "$settings"
echo "Imported $settings"

if [[ "$was_running" == true ]]; then
  open -a Vorssaint
fi
