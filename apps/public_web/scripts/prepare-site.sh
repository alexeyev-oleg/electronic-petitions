#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPO_ROOT="$(cd "$ROOT_DIR/../.." && pwd)"

echo "==> Prepare public_web site assets"
mkdir -p "$ROOT_DIR/mock"

cp "$REPO_ROOT/shared/mock/seed.json" "$ROOT_DIR/mock/seed.json"

echo "Copied:"
echo "  shared/mock/seed.json -> apps/public_web/mock/seed.json"
echo "Done."
