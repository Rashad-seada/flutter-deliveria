# Project Overview

## Introduction
Delveria is a comprehensive multi-role food delivery application built with Flutter. It connects customers, restaurant owners, and delivery agents in a seamless ecosystem. The platform is designed to provide a premium user experience with real-time tracking, secure payments, and a robust admin dashboard.

## High-Level Architecture
The application follows a Clean Architecture approach, separating concerns into distinct layers:
- **Presentation Layer**: UI components and state management (BLoC/Cubit).
- **Domain Layer**: Business logic and entities (though in this project, it's often merged with logic/data for pragmatism).
- **Data Layer**: Repositories, data sources (API, local storage), and models.

The project uses a feature-first structure, where each feature (e.g., `auth`, `home`, `cart`) is self-contained with its own data, logic, and UI.

## Tech Stack
### Core
- **Framework**: Flutter SDK (^3.7.2)
- **Language**: Dart

### State Management
- **Pattern**: BLoC (Business Logic Component)
- **Library**: `flutter_bloc`
- **DI**: `get_it` for dependency injection

### Networking
- **Client**: `dio`
- **Wrapper**: `retrofit` for type-safe API calls
- **Logging**: `pretty_dio_logger`

### Data & Storage
- **Local Storage**: `shared_preferences`
- **Secure Storage**: `flutter_secure_storage`
- **Serialization**: `json_serializable`, `freezed`

### Key Features
- **Maps**: `google_maps_flutter`, `geolocator`
- **Notifications**: `firebase_messaging`, `flutter_local_notifications`
- **Payment**: Paymob integration
- **Localization**: `easy_localization` (English & Arabic)
