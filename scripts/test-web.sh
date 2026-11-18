#!/usr/bin/env bash
# Runs the public-site regression suite (tests/e2e-web) with one command.
# No global dependencies: Playwright is pinned in tests/e2e-web/package-lock.json.
#
#   scripts/test-web.sh                       # whole suite against the working tree
#   scripts/test-web.sh specs/logo.spec.ts    # extra args go to `playwright test`
#   SITE_SRC=/path/to/extract scripts/test-web.sh   # run against another tree with apps/
#   NAV_BREAKPOINT=1100 scripts/test-web.sh   # burger threshold in px (default 900)
#
# In CI set CI=1 to also install the browser's system dependencies.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR/tests/e2e-web"

npm ci --no-audit --no-fund
if [[ -n "${CI:-}" ]]; then
  npx playwright install --with-deps chromium
else
  npx playwright install chromium
fi
npx playwright test "$@"
