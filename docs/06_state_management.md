# State Management

## BLoC Pattern
The application uses the **BLoC (Business Logic Component)** pattern for state management, specifically the `flutter_bloc` library.

### Cubits vs. Blocs
- **Cubits** are used for simpler state management where events are direct function calls.
- **Blocs** are used for more complex scenarios requiring event transformation (though Cubits are preferred for most features in this app).

### Structure
Each feature typically has a `logic` directory containing the Cubit/Bloc.
- **`state.dart`**: Defines the states (e.g., `Initial`, `Loading`, `Success`, `Error`). Uses `freezed` for immutable state unions.
- **`cubit.dart`**: Contains the business logic and emits states.

## Dependency Injection
**GetIt** is used for Service Locator pattern dependency injection.
- **Setup**: All dependencies are registered in `lib/core/di/dependancy_injection.dart`.
- **Usage**: Dependencies are injected into Cubits/Blocs or accessed directly via `getIt<Type>()`.

### Registration Example
```dart
final getIt = GetIt.instance;

void init() {
  // Register Dio
  getIt.registerLazySingleton<DioFactory>(() => DioFactory());
  
  // Register Repository
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(getIt()));
  
  // Register Cubit
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
}
```
