# API Integration

## Overview
The application uses **Dio** for HTTP requests and **Retrofit** for type-safe API client generation. This ensures a robust and maintainable networking layer.

## Configuration
The API configuration is centralized in `lib/core/network/`.
- **`dio_factory.dart`**: Configures the Dio instance with interceptors (logging, auth headers), timeouts, and base URL.
- **`api_services.dart`**: Defines the API endpoints using Retrofit annotations.

## Key Endpoints
All endpoints are defined in `ApiServices` class.
- **Auth**: `/auth/login`, `/auth/register`, `/auth/verify-otp`
- **Restaurants**: `/restaurants`, `/restaurants/{id}`
- **Orders**: `/orders`, `/orders/{id}`
- **Cart**: `/cart`, `/cart/add`, `/cart/remove`
- **Profile**: `/users/profile`, `/users/update`

## Error Handling
Errors are handled using a custom `ApiErrorHandler` and `ApiResult` class (using `freezed`).
- **`ApiResult.success(data)`**: Returns the parsed data.
- **`ApiResult.failure(error)`**: Returns an error object containing the message and code.

## Usage Example
```dart
// Inject the repository
final repo = getIt<AuthRepository>();

// Call the API
final result = await repo.login(email, password);

// Handle the result
result.when(
  success: (response) {
    // Handle success
  },
  failure: (error) {
    // Handle error
  },
);
```
