#!/usr/bin/env bash
set -euo pipefail

REPO="alexeyev-oleg/electronic-petitions"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$ROOT_DIR"

echo "==> GitHub publish: $REPO"

if ! gh auth status -h github.com >/dev/null 2>&1; then
  echo "GitHub CLI auth required. Complete device login:"
  gh auth refresh -h github.com -s repo,workflow,read:org
fi

if ! gh repo view "$REPO" >/dev/null 2>&1; then
  echo "==> Creating repository"
  gh repo create "$REPO" --public --description "G.E.S.H.E.R. electronic petitions monorepo" --source=. --remote=origin
else
  echo "==> Repository exists"
  git remote get-url origin >/dev/null 2>&1 || git remote add origin "https://github.com/${REPO}.git"
fi

echo "==> Pushing main"
git push -u origin main

echo "==> Enabling GitHub Pages (GitHub Actions)"
gh api -X PUT "repos/${REPO}/pages" -f build_type=workflow >/dev/null 2>&1 || true

echo "==> Triggering deploy workflow"
gh workflow run deploy-github-pages.yml --ref main 2>/dev/null || true

echo ""
echo "Repo:  https://github.com/${REPO}"
echo "Pages: https://alexeyev-oleg.github.io/electronic-petitions/"
echo "Staff: https://alexeyev-oleg.github.io/electronic-petitions/staff/"
gh run list --workflow=deploy-github-pages.yml --limit 3 2>/dev/null || true
