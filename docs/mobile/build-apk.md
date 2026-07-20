# Building a Mock APK for Design Review

Use this when you want to install the Resident App on a physical Android device without a backend.

## What You Get
- mock flavor (`main_mock.dart`)
- full UI/UX: onboarding, auth, petitions, complaints, enforcement, profile
- local mock data persisted on device
- beta OTP code: `123456`

## Requirements
- Flutter SDK installed and working (`flutter doctor`)
- Android SDK + accepted licenses
- JDK 17 (used by the project Gradle config)

## Quick Build

```bash
cd "/Users/duck/work/projects/electronic-petitions/apps/resident_app"
chmod +x scripts/build-mock-apk.sh
./scripts/build-mock-apk.sh
```

Output APK (version from `pubspec.yaml`):

```text
apps/resident_app/dist/resident-app-mock-v0.2.0-b1.apk
apps/resident_app/dist/BUILD_INFO.txt
apps/resident_app/dist/resident-app-mock-latest.apk   # symlink to latest build
```

Naming: `resident-app-mock-v{semver}-b{build}.apk` — e.g. `v0.2.0-b1` for `version: 0.2.0+1` in `pubspec.yaml`.

Mock release tag and seed are read from `shared/mock/mobile-release.json`.

Before each new APK, bump the build number:

```bash
cd "/Users/duck/work/projects/electronic-petitions"
./scripts/bump-mobile-build.sh
```

## Manual Build

```bash
cd "/Users/duck/work/projects/electronic-petitions/apps/resident_app"
flutter pub get
flutter build apk --release --target lib/main_mock.dart
```

Gradle output:

```text
apps/resident_app/build/app/outputs/flutter-apk/app-release.apk
```

## Smaller APK per CPU (optional)

```bash
flutter build apk --release --target lib/main_mock.dart --split-per-abi
```

Files:

```text
build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk
build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
build/app/outputs/flutter-apk/app-x86_64-release.apk
```

Most modern phones use `app-arm64-v8a-release.apk`.

## Install on Phone

### USB + adb

```bash
adb install -r "dist/resident-app-mock-0.1.0.apk"
```

### Without adb
1. Copy the APK to the phone (AirDrop, Telegram, Google Drive, etc.).
2. Open the file on Android.
3. Allow install from unknown sources if prompted.

## Notes
- Release APK currently uses debug signing for internal testing only.
- Camera, gallery, location, and microphone permissions are requested when used.
- This is not a Play Store build.

## Troubleshooting
- `flutter doctor -v` — fix Android toolchain issues first.
- `adb install` fails with `Broken pipe` — cold boot emulator or use `--uninstall-first`.
- Old session/data — uninstall the app before reinstalling.
