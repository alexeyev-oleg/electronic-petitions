#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST_DIR="$ROOT_DIR/dist/gh-pages"

echo "==> GitHub Pages smoke test"

chmod +x "$ROOT_DIR/scripts/prepare-github-pages.sh"
"$ROOT_DIR/scripts/prepare-github-pages.sh"

required=(
  "$DIST_DIR/index.html"
  "$DIST_DIR/faq.html"
  "$DIST_DIR/content/faq.json"
  "$DIST_DIR/mock/seed.json"
  "$DIST_DIR/about.html"
  "$DIST_DIR/download.html"
  "$DIST_DIR/staff/index.html"
  "$DIST_DIR/staff/js/admin.js"
)

missing=0
for path in "${required[@]}"; do
  if [[ ! -f "$path" ]]; then
    echo "MISSING: ${path#$ROOT_DIR/}"
    missing=$((missing + 1))
  fi
done

if [[ "$missing" -gt 0 ]]; then
  echo "Smoke test failed: $missing required artifact(s) missing."
  exit 1
fi

echo "Smoke test passed (${#required[@]} artifacts)."
