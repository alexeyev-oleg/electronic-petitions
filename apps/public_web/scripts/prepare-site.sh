#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPO_ROOT="$(cd "$ROOT_DIR/../.." && pwd)"

echo "==> Prepare public_web site assets"
mkdir -p "$ROOT_DIR/mock"
mkdir -p "$ROOT_DIR/media"

cp "$REPO_ROOT/shared/mock/seed.json" "$ROOT_DIR/mock/seed.json"
cp -R "$REPO_ROOT/shared/mock/media/." "$ROOT_DIR/media/"

"$REPO_ROOT/scripts/sync-shared-content.sh"

echo "Copied:"
echo "  shared/mock/seed.json      -> apps/public_web/mock/seed.json"
echo "  shared/mock/media/*        -> apps/public_web/media/"
echo "  shared/content/faq.json    -> apps/public_web/content/faq.json"
echo "Done."
