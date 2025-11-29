# Setup & Installation Guide

## Prerequisites
Before you begin, ensure you have the following installed:
- **Flutter SDK**: Version 3.7.2 or higher
- **Dart SDK**: Compatible with the Flutter version
- **IDE**: Android Studio or VS Code with Flutter extensions
- **Git**: For version control
- **Firebase Account**: For notifications and analytics
- **Paymob Account**: For payment gateway integration

## Installation Steps

1.  **Clone the Repository**
    ```bash
    git clone <repository-url>
    cd delveria-development
    ```

2.  **Install Dependencies**
    ```bash
    flutter pub get
    ```

3.  **Generate Code**
    This project uses code generation for models and API clients. Run the build runner:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

4.  **Asset Generation**
    Generate app icons and splash screens:
    ```bash
    flutter pub run flutter_launcher_icons:main
    flutter pub run flutter_native_splash:create
    ```

5.  **Run the App**
    ```bash
    flutter run
    ```

## Configuration

### Firebase Setup
1.  Create a project in the Firebase Console.
2.  Add Android and iOS apps.
3.  Download `google-services.json` and place it in `android/app/`.
4.  Download `GoogleService-Info.plist` and place it in `ios/Runner/`.
5.  Update `lib/firebase_options.dart` with your specific configuration.

### API Configuration
Navigate to `lib/core/network/api_constants.dart` (or equivalent) and update the base URL:
```dart
class ApiConstants {
  static const String baseUrl = "YOUR_API_BASE_URL";
}
```

### Paymob Integration
To enable payments, you need to configure your Paymob credentials in the API constants or environment variables:
- API Key
- Integration ID
- IFrame ID
