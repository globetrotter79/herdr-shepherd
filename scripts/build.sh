#!/bin/sh
# Build the shepherd binary at install time. herdr runs this as the manifest's
# [[build]] step, in the plugin root. This fork builds from the cloned source
# only: without a Go toolchain the build fails, so no prebuilt release binary
# is ever downloaded in place of the reviewed source. The result is
# ./bin/herdr-shepherd, which the manifest's actions and panes invoke.
set -e
cd "$(dirname "$0")/.."
if ! command -v go >/dev/null 2>&1; then
  echo "herdr-shepherd: no Go toolchain found; install Go and rebuild (this fork never downloads a prebuilt binary)" >&2
  exit 1
fi
mkdir -p bin
exec go build -o bin/herdr-shepherd .
