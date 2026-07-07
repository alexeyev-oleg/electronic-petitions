#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FAQ_SRC="$ROOT_DIR/shared/content/faq.json"

echo "==> Sync shared content to client bundles"

mkdir -p "$ROOT_DIR/apps/public_web/content"
mkdir -p "$ROOT_DIR/apps/resident_app/assets/content"

cp "$FAQ_SRC" "$ROOT_DIR/apps/public_web/content/faq.json"
cp "$FAQ_SRC" "$ROOT_DIR/apps/resident_app/assets/content/faq.json"

echo "  apps/public_web/content/faq.json"
echo "  apps/resident_app/assets/content/faq.json"
echo "Done."
