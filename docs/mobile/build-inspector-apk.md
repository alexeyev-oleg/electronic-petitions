# Building a Mock APK for Inspector App Review

Use this when you want to install the Inspector App on a physical Android device without a backend.

## What You Get
- mock flavor (`main_mock.dart`)
- staff login, triage queue, report detail, inspector actions
- local mock data persisted on device
- staff OTP for protected actions: `123456`

## Requirements
- Flutter SDK installed and working (`flutter doctor`)
- Android SDK + accepted licenses
- JDK 17 (used by the project Gradle config)

## Quick Build

```bash
cd "/Users/duck/work/projects/electronic-petitions/apps/inspector_app"
chmod +x scripts/build-mock-apk.sh
./scripts/build-mock-apk.sh
```

Output APK:

```text
apps/inspector_app/dist/inspector-app-mock-0.1.2.apk
```

## Manual Build

```bash
cd "/Users/duck/work/projects/electronic-petitions/apps/inspector_app"
flutter pub get
flutter build apk --release --target lib/main_mock.dart
```

Gradle output:

```text
apps/inspector_app/build/app/outputs/flutter-apk/app-release.apk
```

## Install on Phone

### USB + adb

```bash
adb install -r "dist/inspector-app-mock-0.1.2.apk"
```

### Without adb
1. Copy the APK to the phone.
2. Open the file on Android.
3. Allow install from unknown sources if prompted.

## Mock Credentials
| Purpose | Value |
|---------|-------|
| Staff login email | `inspector@haifa.mock` |
| Staff login password | `inspector123` |
| Protected action OTP | `123456` |

## Notes
- Release APK currently uses debug signing for internal testing only.
- This is not a Play Store build.
- Install **Resident App** and **Inspector App** side by side — they use different package IDs.

## Troubleshooting
- `flutter doctor -v` — fix Android toolchain issues first.
- Old session/data — uninstall the app before reinstalling.
- See `docs/mobile/user-guides/inspector-triage.md` for workflow steps.
