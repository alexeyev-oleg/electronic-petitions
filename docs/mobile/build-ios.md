# iOS Build Guide (Resident App)

Use this when you want to run or share the app on iPhone/iPad without a backend.

## Requirements
- macOS with Xcode installed
- Flutter SDK (`flutter doctor`)
- CocoaPods (`pod --version`)
- iOS Simulator runtime or a physical device

## Check Environment
```bash
flutter doctor -v
xcodebuild -version
```

If `flutter doctor` reports missing iOS simulator runtimes:
1. Open Xcode → Settings → Platforms
2. Install an iOS simulator runtime
3. Run `flutter doctor` again

## Install Pods
```bash
cd "/Users/duck/work/projects/electronic-petitions/apps/resident_app/ios"
pod install
cd ..
```

## Run on Simulator
```bash
cd "/Users/duck/work/projects/electronic-petitions/apps/resident_app"
flutter pub get
flutter run --target lib/main_mock.dart
```

Pick a simulator when prompted, or specify:
```bash
flutter devices
flutter run -d <device-id> --target lib/main_mock.dart
```

## Release Build for Device (no App Store)
```bash
flutter build ios --release --target lib/main_mock.dart --no-codesign
```

Open `ios/Runner.xcworkspace` in Xcode to sign and run on a connected device.

## Permissions Already Declared
`ios/Runner/Info.plist` includes usage descriptions for:
- camera
- photo library
- location
- microphone (video evidence)

## Beta Mock OTP
Use **`123456`** for phone verification and sensitive actions.

## Troubleshooting
- `pod install` fails → run `sudo gem install cocoapods` or use Homebrew CocoaPods
- Codesign errors → select a development team in Xcode Signing & Capabilities
- White screen on launch → run `flutter clean && flutter pub get`
