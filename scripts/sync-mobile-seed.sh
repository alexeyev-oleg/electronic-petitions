#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SEED_SRC="$ROOT_DIR/shared/mock/seed.json"
MEDIA_SRC="$ROOT_DIR/shared/mock/media"

echo "==> Sync shared mock seed to mobile asset bundles"

for APP in resident_app inspector_app; do
  DEST_DIR="$ROOT_DIR/apps/$APP/assets/mock"
  MEDIA_DEST="$DEST_DIR/media"
  mkdir -p "$MEDIA_DEST"
  cp "$SEED_SRC" "$DEST_DIR/seed.json"
  if [[ -d "$MEDIA_SRC" ]]; then
    cp -R "$MEDIA_SRC/." "$MEDIA_DEST/"
  fi
  echo "  apps/$APP/assets/mock/seed.json"
  echo "  apps/$APP/assets/mock/media/*"
done

echo "Done."
