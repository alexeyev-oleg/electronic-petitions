#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

chmod +x scripts/prepare-github-pages.sh
./scripts/prepare-github-pages.sh

PORT="${PORT:-4173}"
PREVIEW_DIR="$ROOT_DIR/dist/local-pages-preview"
SITE_PREFIX="electronic-petitions"

rm -rf "$PREVIEW_DIR"
mkdir -p "$PREVIEW_DIR/$SITE_PREFIX"
cp -R dist/gh-pages/. "$PREVIEW_DIR/$SITE_PREFIX/"

echo
echo "Serving combined site at http://127.0.0.1:${PORT}"
echo "  Public: http://127.0.0.1:${PORT}/${SITE_PREFIX}/index.html"
echo "  Staff:  http://127.0.0.1:${PORT}/${SITE_PREFIX}/staff/index.html"
echo
echo "Matches GitHub Pages basePath (/${SITE_PREFIX}/)."
python3 -m http.server "$PORT" --directory "$PREVIEW_DIR"
