#!/usr/bin/env bash
# Build both mock mobile APKs (resident + inspector). Run in your local Terminal — Flutter
# cannot run inside the Cursor agent sandbox on macOS (sysctl blocked).
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> G.E.S.H.E.R. mock mobile APKs"
echo "    repo: $ROOT_DIR"
echo

"$ROOT_DIR/apps/resident_app/scripts/build-mock-apk.sh"
echo
"$ROOT_DIR/apps/inspector_app/scripts/build-mock-apk.sh"

echo
echo "==> Done"
echo "  $ROOT_DIR/apps/resident_app/dist/resident-app-mock-latest.apk"
echo "  $ROOT_DIR/apps/inspector_app/dist/inspector-app-mock-latest.apk"
