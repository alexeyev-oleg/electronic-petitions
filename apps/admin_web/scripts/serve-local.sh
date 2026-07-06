#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

chmod +x scripts/prepare-site.sh
./scripts/prepare-site.sh

PORT="${PORT:-4173}"
echo
echo "Serving admin_web at http://127.0.0.1:${PORT}"
echo "Login: moderator@gesher.mock / staff123"
python3 -m http.server "$PORT"
