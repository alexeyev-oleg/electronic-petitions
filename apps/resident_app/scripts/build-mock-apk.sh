#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

TARGET="lib/main_mock.dart"
APP_ID="resident_app"
MONOREPO_ROOT="$(cd "$ROOT_DIR/../.." && pwd)"
# shellcheck source=/dev/null
source "$MONOREPO_ROOT/scripts/flutter-app-version.sh"
read_flutter_app_version "$ROOT_DIR"

DIST_DIR="$ROOT_DIR/dist"
APK_NAME="resident-app-mock-${FLUTTER_APK_VERSION_SLUG}.apk"
GRADLE_APK="$ROOT_DIR/build/app/outputs/flutter-apk/app-release.apk"

echo "==> Resident App mock APK build"
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

# Always resolve deps so new packages (e.g. qr_flutter) are picked up.
flutter pub get

flutter build apk --release --target "$TARGET" \
  --build-name="$FLUTTER_VERSION_NAME" \
  --build-number="$FLUTTER_BUILD_NUMBER"

if [[ ! -f "$GRADLE_APK" ]]; then
  echo "Error: expected APK was not created at:" >&2
  echo "  $GRADLE_APK" >&2
  exit 1
fi

mkdir -p "$DIST_DIR"
cp "$GRADLE_APK" "$DIST_DIR/$APK_NAME"
ln -sf "$APK_NAME" "$DIST_DIR/resident-app-mock-latest.apk"
write_dist_build_manifest "$DIST_DIR" "$APP_ID" "$APK_NAME"

echo
echo "Build complete."
echo "APK (copy/share this file):"
echo "  $DIST_DIR/$APK_NAME"
echo "Manifest:"
echo "  $DIST_DIR/BUILD_INFO.txt"
echo
echo "Install on a connected device:"
echo "  adb install -r \"$DIST_DIR/$APK_NAME\""
echo
echo "Beta mock OTP for phone / sensitive actions: 123456"
