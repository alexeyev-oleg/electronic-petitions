#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

shopt -s nullglob
files=(
  "$ROOT_DIR"/apps/public_web/js/*.js
  "$ROOT_DIR"/apps/admin_web/js/*.js
  "$ROOT_DIR"/shared/mock/mock-store.js
)

if [[ ${#files[@]} -eq 0 ]]; then
  echo "No JavaScript files found to check."
  exit 1
fi

echo "==> JavaScript syntax check (node --check)"

for file in "${files[@]}"; do
  rel="${file#$ROOT_DIR/}"
  echo "  $rel"
  node --check "$file"
done

echo "Done. ${#files[@]} files OK."
