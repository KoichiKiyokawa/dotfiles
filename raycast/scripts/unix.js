#!/usr/bin/env node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title unix
// @raycast.mode compact
// @raycast.refreshTime 1d

// Optional parameters:
// @raycast.icon 🕒
// @raycast.argument1 { "type": "text", "placeholder": "now or 1665846691" }

// Documentation:
// @raycast.description convert unix time to date

const arg = process.argv[2]
if (!arg || arg === "now") {
  console.log(Math.trunc(Date.now() / 1000))
} else {
  const unix = Number(arg)
  if (!Number.isFinite(unix)) {
    console.error("Invalid unix time. Use 'now' or unix seconds (e.g. 1665846691).")
    process.exit(1)
  }
  console.log(new Date(unix * 1000).toISOString())
}
