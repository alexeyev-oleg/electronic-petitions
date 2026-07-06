#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

chmod +x scripts/prepare-github-pages.sh
./scripts/prepare-github-pages.sh

PORT="${PORT:-4173}"
echo
echo "Serving combined site at http://127.0.0.1:${PORT}"
echo "  Public: http://127.0.0.1:${PORT}/index.html"
echo "  Staff:  http://127.0.0.1:${PORT}/staff/index.html"
python3 -m http.server "$PORT" --directory dist/gh-pages
