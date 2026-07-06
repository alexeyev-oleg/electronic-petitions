# FAQ and Troubleshooting

## Login and Account
### I cannot sign in
- Check that your email format is valid.
- For sign-up, use at least 8 characters in the password.
- Try `Log out` and sign in again if the session looks stale.

### What OTP code should I use?
In this beta mock build, use **`123456`** for:
- phone verification
- sensitive action confirmation (for example petition signing)

## Location
### The app asks for location permission
This is expected when you create a complaint or violation report. Location helps attach coordinates to the case.

### GPS looks wrong or outside the city
Use manual address entry when the app shows a geo mismatch warning. This is intentional beta behavior for low-confidence locations.

## Media
### Camera, gallery, or microphone permission
These permissions are requested only when you attach photo or video evidence. Video recording may require microphone access on iOS.

### Photos do not appear after restart
Media files stay on the device, but OS temp files may be cleared. Re-attach media if previews disappear after a long time.

## Inspector App
Staff triage mock APK: `docs/mobile/build-inspector-apk.md`

### What login should inspectors use?
- Email: `inspector@haifa.mock`
- Password: `inspector123`

### What OTP code is used for inspector actions?
Use **`123456`** when confirming invalid, merge, dispatch, or validated outcome actions.

### Why do report IDs match the Resident App?
Demo enforcement reports `e1`, `e2`, and `e3` are shared between apps. See `docs/mobile/mock-demo-data.md`.

## Petitions
### What can I attach to a petition?
Up to **5 files total**:
- photos from camera or gallery
- PDF, Word (`.doc`/`.docx`), or Excel (`.xls`/`.xlsx`)

Video is not supported for petitions in this beta build.

### Seed petition attachments show icons instead of previews
Demo petitions use mock attachment paths. Real photos and files appear after you create a petition and attach files from your device.

## Lists and Data
### A list shows an error state
1. Tap `Retry`.
2. In Profile, turn off `Simulate list load error` if you enabled it for testing.

### My created complaint disappeared
In mock mode, data should persist on the device. If you cleared app storage or reinstalled, seed data returns without your items.

## APK Install (Android)
### Install blocked
Allow installation from unknown sources for the file manager or browser you use.

### `adb install` fails
Try cold booting the emulator or:
```bash
adb install -r path/to/resident-app-mock-0.1.2.apk
```

## iOS
See `docs/mobile/build-ios.md` for simulator/device build steps. Simulator runtimes must be installed via Xcode.
