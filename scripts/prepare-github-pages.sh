#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST_DIR="$ROOT_DIR/dist/gh-pages"

echo "==> Prepare combined GitHub Pages site"
rm -rf "$DIST_DIR"
mkdir -p "$DIST_DIR/staff"

chmod +x "$ROOT_DIR/apps/public_web/scripts/prepare-site.sh"
chmod +x "$ROOT_DIR/apps/admin_web/scripts/prepare-site.sh"

"$ROOT_DIR/apps/public_web/scripts/prepare-site.sh"
"$ROOT_DIR/apps/admin_web/scripts/prepare-site.sh"
"$ROOT_DIR/scripts/sync-mobile-seed.sh"

cp -R "$ROOT_DIR/apps/public_web/." "$DIST_DIR/"
cp -R "$ROOT_DIR/apps/admin_web/." "$DIST_DIR/staff/"

echo "Built:"
echo "  Public site -> dist/gh-pages/"
echo "  Staff portal -> dist/gh-pages/staff/"
echo "Done."
