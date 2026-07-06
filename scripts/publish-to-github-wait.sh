#!/usr/bin/env bash
set -euo pipefail

REPO="alexeyev-oleg/electronic-petitions"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG="${ROOT_DIR}/.publish-github.log"

cd "$ROOT_DIR"
exec > >(tee -a "$LOG") 2>&1

echo "=== $(date -u +%Y-%m-%dT%H:%M:%SZ) publish-to-github wait loop ==="

for i in $(seq 1 120); do
  if gh auth status -h github.com >/dev/null 2>&1; then
    echo "Auth OK after ${i} attempts"
    break
  fi
  if [[ "$i" -eq 1 ]]; then
    echo "Waiting for gh auth (complete device login if prompted)..."
  fi
  if [[ "$i" -eq 120 ]]; then
    echo "Timed out waiting for gh auth"
    exit 1
  fi
  sleep 5
done

if ! gh repo view "$REPO" >/dev/null 2>&1; then
  echo "Creating $REPO"
  gh repo create "$REPO" --public --description "G.E.S.H.E.R. electronic petitions monorepo" --source=. --remote=origin
fi

git remote get-url origin >/dev/null 2>&1 || git remote add origin "https://github.com/${REPO}.git"
git push -u origin main

gh api -X PUT "repos/${REPO}/pages" -f build_type=workflow >/dev/null 2>&1 || true
gh workflow run deploy-github-pages.yml --ref main 2>/dev/null || true

echo "DONE repo=https://github.com/${REPO}"
echo "PAGES=https://alexeyev-oleg.github.io/electronic-petitions/"
gh run list --workflow=deploy-github-pages.yml --limit 1 2>/dev/null || true
