#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPO_ROOT="$(cd "$ROOT_DIR/../.." && pwd)"

echo "==> Prepare admin_web site assets"
mkdir -p "$ROOT_DIR/mock"
mkdir -p "$ROOT_DIR/js"

cp "$REPO_ROOT/shared/mock/seed.json" "$ROOT_DIR/mock/seed.json"
cp "$REPO_ROOT/shared/mock/mock-store.js" "$ROOT_DIR/js/mock-store.js"

echo "Copied:"
echo "  shared/mock/seed.json      -> apps/admin_web/mock/seed.json"
echo "  shared/mock/mock-store.js  -> apps/admin_web/js/mock-store.js"
echo "Done."
