#!/usr/bin/env bash
# Bump Flutter build number (+N) in resident and inspector pubspec.yaml files.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

bump_pubspec() {
  local pubspec="$1"
  local full name build
  full="$(awk '/^version:/{print $2; exit}' "$pubspec")"
  name="${full%%+*}"
  build="${full#*+}"
  if [[ "$build" == "$name" ]]; then
    build="1"
  fi
  build=$((build + 1))
  sed -i '' "s/^version: .*/version: ${name}+${build}/" "$pubspec"
  echo "  $(basename "$(dirname "$pubspec")"): ${name}+${build}"
}

echo "==> Bump mobile build numbers"
for app in resident_app inspector_app; do
  bump_pubspec "$ROOT_DIR/apps/$app/pubspec.yaml"
done
