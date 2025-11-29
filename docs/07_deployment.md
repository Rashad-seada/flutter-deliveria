# Deployment Guide

## Android

### Build APK
To build a release APK:
```bash
flutter build apk --release
```
The output will be in `build/app/outputs/flutter-apk/app-release.apk`.

### Build App Bundle
For Google Play Store deployment:
```bash
flutter build appbundle --release
```
The output will be in `build/app/outputs/bundle/release/app-release.aab`.

### Signing
Ensure you have configured the keystore in `android/key.properties` and updated `android/app/build.gradle` to use the release signing config.

## iOS

### Build Archive
To build for the App Store:
1.  Open `ios/Runner.xcworkspace` in Xcode.
2.  Select **Product > Archive**.
3.  Once archived, use the **Organizer** to validate and upload to TestFlight or the App Store.

### Certificates & Profiles
Ensure you have valid certificates and provisioning profiles set up in your Apple Developer account and Xcode.

## Web
To build for the web:
```bash
flutter build web --release
```
The output will be in `build/web/`.

## CI/CD
It is recommended to set up a CI/CD pipeline (e.g., GitHub Actions, Codemagic) to automate the build and deployment process.
