#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

TARGET="lib/main_mock.dart"
VERSION="$(awk '/^version:/{print $2}' pubspec.yaml | cut -d+ -f1)"
DIST_DIR="$ROOT_DIR/dist"
APK_NAME="resident-app-mock-${VERSION}.apk"
GRADLE_APK="$ROOT_DIR/build/app/outputs/flutter-apk/app-release.apk"

echo "==> Resident App mock APK build"
echo "    project: $ROOT_DIR"
echo "    target:  $TARGET"
echo "    version: $VERSION"
echo

if ! command -v flutter >/dev/null 2>&1; then
  echo "Error: flutter not found in PATH." >&2
  exit 1
fi

flutter pub get
flutter build apk --release --target "$TARGET"

if [[ ! -f "$GRADLE_APK" ]]; then
  echo "Error: expected APK was not created at:" >&2
  echo "  $GRADLE_APK" >&2
  exit 1
fi

mkdir -p "$DIST_DIR"
cp "$GRADLE_APK" "$DIST_DIR/$APK_NAME"

echo
echo "Build complete."
echo "APK (copy/share this file):"
echo "  $DIST_DIR/$APK_NAME"
echo
echo "Install on a connected device:"
echo "  adb install -r \"$DIST_DIR/$APK_NAME\""
echo
echo "Beta mock OTP for phone / sensitive actions: 123456"
