# Resident App

Mobile app for municipal petitions, complaints, and violation reporting.

## Flavors
| Entry point | Purpose |
|-------------|---------|
| `lib/main_mock.dart` | Mock data, beta UX review (default for APK demo) |
| `lib/main_dev.dart` | Dev environment shell |
| `lib/main_staging.dart` | Staging shell |
| `lib/main_prod.dart` | Production shell |

## Run on Emulator

```bash
cd apps/resident_app
flutter pub get
flutter emulators --launch Pixel_XL_API_30
flutter run -d emulator-5554 --target lib/main_mock.dart --uninstall-first
```

## Build APK for Design / UX Review

```bash
cd apps/resident_app
chmod +x scripts/build-mock-apk.sh
./scripts/build-mock-apk.sh
```

APK path after build:

```text
dist/resident-app-mock-0.1.2.apk
```

See also: `docs/mobile/build-apk.md`

## Beta Testing Shortcuts
- Mock OTP (phone verify + sensitive actions): `123456`
- Profile → simulate list load error (mock QA toggle)

## Docs
- `docs/mobile/resident-app-roadmap.md`
- `docs/mobile/design-system.md`
- `docs/mobile/user-guides/`
