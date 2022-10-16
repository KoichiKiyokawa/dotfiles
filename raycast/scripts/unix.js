#!/usr/bin/env deno run

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

const arg = Deno.args[0]
if (arg === "now") {
  console.log(Math.trunc(Date.now() / 1000))
} else {
  console.log(new Date(Number(arg) * 1000).toISOString())
}
