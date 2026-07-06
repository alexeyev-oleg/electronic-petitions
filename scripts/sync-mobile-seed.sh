#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SEED_SRC="$ROOT_DIR/shared/mock/seed.json"

echo "==> Sync shared mock seed to mobile asset bundles"

for APP in resident_app inspector_app; do
  DEST_DIR="$ROOT_DIR/apps/$APP/assets/mock"
  mkdir -p "$DEST_DIR"
  cp "$SEED_SRC" "$DEST_DIR/seed.json"
  echo "  apps/$APP/assets/mock/seed.json"
done

echo "Done."
