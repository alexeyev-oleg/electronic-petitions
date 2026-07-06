# Inspector App

Mobile app for municipal enforcement triage, dispatch, and validated outcomes.

## Run (mock)

```bash
cd apps/inspector_app
flutter pub get
flutter run --target lib/main_mock.dart
```

## Mock login

- Email: `inspector@haifa.mock`
- Password: `inspector123`
- Mock OTP for inspector actions: `123456`

Session persists locally via `SharedPreferences` until sign out.

## Build APK

```bash
chmod +x scripts/build-mock-apk.sh
./scripts/build-mock-apk.sh
```

Output:

```text
dist/inspector-app-mock-0.1.2.apk
```

## Roadmap

See `docs/mobile/inspector-app-roadmap.md`

## User guide

See `docs/mobile/user-guides/inspector-triage.md`

## Build docs

See `docs/mobile/build-inspector-apk.md`
