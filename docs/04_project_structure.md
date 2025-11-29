# Project Structure

The project follows a modular structure to ensure scalability and maintainability.

## Root Directory
- `android/`, `ios/`, `web/`, `windows/`, `linux/`, `macos/`: Platform-specific configuration files.
- `assets/`: Contains static assets like images, fonts, icons, and translation files.
- `lib/`: The main source code directory.
- `test/`: Unit and widget tests.
- `pubspec.yaml`: Project dependencies and configuration.

## Lib Directory (`lib/`)

### `core/`
Contains shared utilities and configurations used across the entire application.
- **di/**: Dependency injection setup (`get_it`).
- **func/**: Utility functions (e.g., notifications, URL launcher).
- **helper/**: Helper classes (constants, extensions, shared prefs).
- **network/**: API configuration (Dio, Retrofit, error handling).
- **routing/**: Navigation setup (`app_router.dart`).
- **theme/**: App theming (colors, styles).
- **widgets/**: Reusable UI components.

### `features/`
Contains the feature-specific code, organized by user role.
- **client/**: Features for the customer app (auth, home, cart, etc.).
- **ResturantOwner/**: Features for the restaurant dashboard.
- **deliveryAgent/**: Features for the delivery driver app.
- **admin/**: Features for the admin panel.

Each feature typically follows this internal structure:
- `data/`: Models and Repositories.
- `logic/`: State management (Cubits/Blocs).
- `ui/`: Screens and Widgets.

### `main.dart`
The entry point of the application. It initializes dependencies, sets up the theme, and starts the app.

### `delveria_app.dart`
The root widget of the application, handling localization, routing, and global providers.
