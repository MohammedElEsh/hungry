# Architecture

This document describes the project structure and architectural patterns used in Hungry. Use it as a reference when building new features or starting a new project.

## Project Structure Overview

```mermaid
flowchart TB
    subgraph lib [lib]
        subgraph core [core]
            domain[domain: Result, Failure]
            di[di: GetIt]
            network[network: DioClient]
            storage[storage]
            router[router]
            theme[theme]
        end

        subgraph features [features]
            auth[auth]
            cart[cart]
            home[home]
            product[product]
            orders[orders]
            profile[profile]
            checkout[checkout]
        end

        main[main.dart]
    end

    main --> core
    features --> core
```

## lib/ Division

| Folder | Purpose |
|--------|---------|
| `core/` | Shared utilities, network, storage, theme, DI, and cross-cutting concerns. No feature-specific logic. |
| `features/` | Feature modules, each with its own domain, data, and presentation layers. |
| `main.dart` | App entry point, DI init, theme, routing, and error handling setup. |
| `splash/` | Splash screen and initial load flow. |
| `onboarding/` | Onboarding screens. |

## Clean Architecture Layers

Each feature follows Clean Architecture with three layers:

```mermaid
flowchart LR
    subgraph presentation [Presentation]
        Cubit[Cubit]
        Screens[Screens]
        Views[Views]
        Widgets[Widgets]
    end

    subgraph domain [Domain]
        Entities[Entities]
        RepoInterface[Repository Interfaces]
        UseCases[Use Cases]
    end

    subgraph data [Data]
        DataSources[DataSources]
        Models[Models]
        RepoImpl[Repository Implementations]
    end

    presentation --> domain
    data --> domain
```

### Dependency Flow

- **Domain** – No dependencies on other layers. Contains entities, repository interfaces, and use cases. May depend on `core/domain` for Result, Failure.
- **Data** – Depends on domain. Implements repositories, calls remote/local datasources, maps models to entities.
- **Presentation** – Depends on domain only. Uses use cases via Cubit; never imports data layer directly.

### Layer Responsibilities

| Layer | Contains | Depends On |
|-------|----------|------------|
| Domain | Entities, repository interfaces, use cases | `core/domain` (Result, Failure) |
| Data | DataSources, models, repository implementations | Domain, core (network, storage) |
| Presentation | Cubit, screens, views, widgets, listeners | Domain (use cases, entities) |

## Core vs Features

```mermaid
flowchart TB
    subgraph core
        result[Result / Failure]
        dio[DioClient]
        storage[Storage]
        di[GetIt]
        router[AppRouter]
    end

    subgraph feature_auth [feature: auth]
        auth_repo[AuthRepository impl]
        auth_cubit[AuthCubit]
        login_usecase[LoginUseCase]
    end

    subgraph feature_cart [feature: cart]
        cart_repo[CartRepository impl]
        cart_cubit[CartCubit]
        add_cart_usecase[AddToCartUseCase]
    end

    auth_repo --> dio
    auth_repo --> storage
    auth_repo --> result
    login_usecase --> auth_repo
    auth_cubit --> login_usecase

    cart_repo --> dio
    cart_repo --> result
    add_cart_usecase --> cart_repo
    cart_cubit --> add_cart_usecase
```

- **core** provides Result/Failure, network, storage, DI, router, and other shared services.
- **features** depend on core and their own domain; they do not depend on each other.

## Examples from the Codebase

### Auth Feature

- **Domain:** `AuthRepository` (interface), `LoginUseCase`, `RegisterUseCase`, `LogoutUseCase`, `UserEntity`
- **Data:** `AuthRepositoryImpl`, `AuthRemoteDataSource`, maps API response to `UserEntity`
- **Presentation:** `AuthCubit`, `LoginScreen`, `SignupScreen`, `LoginForm`, `AuthListener`

### Cart Feature

- **Domain:** `CartRepository` (interface), `AddToCartUseCase`, `GetCartItemsUseCase`, `CartItemEntity`, `CartData`
- **Data:** `CartRepositoryImpl`, `CartRemoteDataSource`, `CartItemModel`
- **Presentation:** `CartCubit`, `CartScreen`, `CartViewFactory`, `CartItem` widget, `CartListener`

## Result / Failure

All use cases return `Result<T>` from `lib/core/domain/result.dart`:

- `Success<T>` – operation succeeded, contains data
- `FailureResult<T>` – operation failed, contains `Failure`

Failure types live in `lib/core/domain/failures.dart`:

- `NetworkFailure`, `ServerFailure`, `CacheFailure`, `AuthFailure`, `UnimplementedFailure`

Use `result.when(success: (data) => ..., onFailure: (f) => ...)` to handle both cases. This keeps error handling consistent across all features.

## Dependency Injection

`lib/core/di/injection.dart` registers all dependencies with GetIt (`sl`). Use cases, repositories, datasources, and Cubits are registered there. Inject dependencies via constructor; avoid direct instantiation or singletons outside DI.
