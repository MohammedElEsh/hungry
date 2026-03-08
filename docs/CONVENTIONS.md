# Conventions

This document describes naming, import, and code conventions used in Hungry. Follow them for consistency and easier maintenance.

## File Naming

| Type | Convention | Example |
|------|------------|---------|
| Dart files | `snake_case` | `auth_repository.dart` |
| Folders | `snake_case` | `data/`, `presentation/` |
| Test files | Suffix `_test` | `auth_repository_test.dart` |

## Class Naming

| Type | Convention | Example |
|------|------------|---------|
| Classes | `PascalCase` | `AuthRepository`, `UserEntity` |
| Abstract / interface | Same as class | `AuthRepository` (abstract) |
| Implementation | Suffix `Impl` | `AuthRepositoryImpl` |
| Models (data) | Suffix `Model` | `UserModel`, `CartItemModel` |
| Entities (domain) | Suffix `Entity` | `UserEntity`, `CartItemEntity` |
| Use cases | Suffix `UseCase` | `LoginUseCase`, `AddToCartUseCase` |
| Constants | Prefix `k` | `kLoginView`, `kHomeView` |

## Imports

- Prefer **package imports** over relative imports:
  ```dart
  import 'package:hungry/core/domain/result.dart';
  import 'package:hungry/features/auth/domain/entities/user_entity.dart';
  ```
- Order: `dart:` first, then `package:`, then `relative` if needed.
- Group: one blank line between dart, package, and project imports.
- Use `core/error/failures.dart` for failures (re-exports `core/domain/failures.dart`).

## Result / Failure

- All use cases return `Result<T>`:
  ```dart
  Future<Result<UserEntity>> call(String email, String password) {
    return _repository.login(email, password);
  }
  ```
- Handle with `result.when`:
  ```dart
  result.when(
    success: (user) => emit(AuthLoaded(user)),
    onFailure: (f) => emit(AuthError(f.message)),
  );
  ```
- Failure types: `NetworkFailure`, `ServerFailure`, `CacheFailure`, `AuthFailure`, `UnimplementedFailure`.

## Routes

- Use constants from `AppRouter`:
  ```dart
  context.go(AppRouter.kHomeView);
  context.push(AppRouter.kProductView, extra: productId);
  ```
- Query params: `AppRouter.kProductView` + `?id=123` or `extra: productId`.

## Cubit State

- Extend `Equatable` for state classes.
- Naming: `FeatureLoaded`, `FeatureLoading`, `FeatureError`, `FeatureInitial`.
- Emit loading before async, then loaded or error.

## Dependency Injection

- Register in `lib/core/di/injection.dart`.
- Use `registerLazySingleton` for long-lived services (repositories, DioClient).
- Use `registerFactory` for short-lived (Cubits created per route).
- Inject via constructor; avoid `GetIt.instance` or `sl<>` in repositories/use cases except in `main.dart`, routers, or top-level widgets.
