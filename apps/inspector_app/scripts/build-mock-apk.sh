#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

TARGET="lib/main_mock.dart"
APP_ID="inspector_app"
MONOREPO_ROOT="$(cd "$ROOT_DIR/../.." && pwd)"
# shellcheck source=/dev/null
source "$MONOREPO_ROOT/scripts/flutter-app-version.sh"
read_flutter_app_version "$ROOT_DIR"

DIST_DIR="$ROOT_DIR/dist"
APK_NAME="inspector-app-mock-${FLUTTER_APK_VERSION_SLUG}.apk"
GRADLE_APK="$ROOT_DIR/build/app/outputs/flutter-apk/app-release.apk"

echo "==> Inspector App mock APK build"
echo "    project:      $ROOT_DIR"
echo "    target:       $TARGET"
echo "    version:      $FLUTTER_VERSION_FULL"
echo "    mock release: $MOCK_RELEASE"
echo "    seed:         $MOCK_SEED_VERSION"
echo

if ! command -v flutter >/dev/null 2>&1; then
  echo "Error: flutter not found in PATH." >&2
  exit 1
fi

MONOREPO_ROOT="$(cd "$ROOT_DIR/../.." && pwd)"
echo "==> Brand launcher icons"
python3 "$MONOREPO_ROOT/scripts/generate-gesher-app-icon.py"
python3 "$MONOREPO_ROOT/scripts/apply-android-launcher-icons.py" "$ROOT_DIR"

write_app_build_info_dart "$ROOT_DIR"

PUB_ARGS=()
if [[ -f "$ROOT_DIR/.dart_tool/package_config.json" ]]; then
  echo "==> Dependencies already resolved (flutter build --no-pub)"
  PUB_ARGS=(--no-pub)
else
  flutter pub get
fi

flutter build apk --release --target "$TARGET" \
  "${PUB_ARGS[@]}" \
  --build-name="$FLUTTER_VERSION_NAME" \
  --build-number="$FLUTTER_BUILD_NUMBER"

if [[ ! -f "$GRADLE_APK" ]]; then
  echo "Error: expected APK was not created at:" >&2
  echo "  $GRADLE_APK" >&2
  exit 1
fi

mkdir -p "$DIST_DIR"
cp "$GRADLE_APK" "$DIST_DIR/$APK_NAME"
ln -sf "$APK_NAME" "$DIST_DIR/inspector-app-mock-latest.apk"
write_dist_build_manifest "$DIST_DIR" "$APP_ID" "$APK_NAME"

echo
echo "Build complete."
echo "APK:"
echo "  $DIST_DIR/$APK_NAME"
echo "Manifest:"
echo "  $DIST_DIR/BUILD_INFO.txt"
echo
echo "Mock inspector login:"
echo "  inspector@haifa.mock / inspector123"
echo "Mock staff OTP for actions: 123456"
