# Feature Structure

This document describes the standard structure for a feature module and shows real examples from the auth and cart features.

## Standard Feature Layout

```
features/<feature_name>/
├── data/
│   ├── datasources/           # Remote / local data access
│   │   └── <feature>_remote_datasource.dart
│   ├── models/                # JSON serialization → entities
│   │   └── <entity>_model.dart
│   └── repositories/
│       └── <feature>_repository_impl.dart
├── domain/
│   ├── entities/              # Business objects
│   │   └── <entity>_entity.dart
│   ├── repositories/          # Abstract contracts
│   │   └── <feature>_repository.dart
│   └── usecases/              # Single-responsibility operations
│       └── <action>_usecase.dart
└── presentation/
    ├── cubit/                 # State management
    │   ├── <feature>_cubit.dart
    │   └── <feature>_state.dart
    ├── screens/               # Full screens (route targets)
    │   └── <feature>_screen.dart
    ├── views/                 # UI by state (loading, loaded, error)
    │   ├── <feature>_view_factory.dart
    │   ├── <feature>_loading_view.dart
    │   ├── <feature>_loaded_view.dart
    │   └── <feature>_error_view.dart
    ├── widgets/               # Feature-specific UI components
    │   └── <widget>_widget.dart
    ├── listeners/             # Listen to Cubit, show snackbars/toasts
    │   └── <feature>_listener.dart
    └── handlers/              # Button/gesture handlers (optional)
        └── <feature>_handlers.dart
```

## When to Use Views vs Widgets

| Use | When |
|-----|------|
| **Views** | Represent full UI for a single Cubit state. `CartLoadedView` shows the cart when data is loaded; `CartLoadingView` shows a spinner. |
| **View Factory** | Selects which view to show based on Cubit state (e.g. `BlocBuilder` that returns `CartLoadedView` or `CartErrorView`). |
| **Widgets** | Reusable pieces within a view or screen (e.g. `CartItem`, `QuantitySelector`). Keep them in `widgets/` if they're specific to the feature. |
| **Screens** | Top-level route target. Wraps views, provides scaffold, handles BlocProvider. |

## Example: Auth Feature

```
features/auth/
├── data/
│   ├── datasources/
│   │   └── auth_remote_datasource.dart   # login, register, logout API calls
│   ├── models/
│   │   └── user_model.dart               # UserModel.fromJson
│   └── repositories/
│       ├── auth_repository_impl.dart     # implements AuthRepository
│       └── auth_repo.dart                # session state + profile API
├── domain/
│   ├── entities/
│   │   └── user_entity.dart
│   ├── auth_state_source.dart            # isLoggedIn, isGuest, currentUser
│   ├── repositories/
│   │   └── auth_repository.dart          # abstract: login, register, logout
│   └── usecases/
│       ├── login_usecase.dart
│       ├── register_usecase.dart
│       ├── logout_usecase.dart
│       ├── get_cached_user_usecase.dart
│       ├── login_with_google_usecase.dart
│       └── login_with_apple_usecase.dart
└── presentation/
    ├── cubit/
    │   ├── auth_cubit.dart
    │   └── auth_state.dart
    ├── screens/
    │   ├── login_screen.dart
    │   ├── signup_screen.dart
    │   └── forget_password_screen.dart
    ├── views/
    │   ├── login_view_factory.dart       # picks view by AuthState
    │   ├── login_form_view.dart
    │   ├── login_loading_view.dart
    │   └── signup_form_view.dart
    ├── widgets/
    │   ├── login_form.dart
    │   ├── signup_form.dart
    │   └── custom_text_field.dart
    ├── listeners/
    │   └── auth_listener.dart            # BlocListener for snackbars
    └── handlers/
        └── auth_handlers.dart            # onLogin, onRegister callbacks
```

## Example: Cart Feature

```
features/cart/
├── data/
│   ├── datasources/
│   │   └── cart_remote_datasource.dart   # get cart, add, remove, clear
│   ├── models/
│   │   └── cart_item_model.dart
│   └── repositories/
│       └── cart_repository_impl.dart
├── domain/
│   ├── entities/
│   │   ├── cart_item_entity.dart
│   │   └── cart_data.dart
│   ├── repositories/
│   │   └── cart_repository.dart
│   └── usecases/
│       ├── get_cart_items_usecase.dart
│       ├── add_to_cart_usecase.dart
│       ├── remove_from_cart_usecase.dart
│       └── clear_cart_usecase.dart
└── presentation/
    ├── cubit/
    │   ├── cart_cubit.dart
    │   └── cart_state.dart
    ├── screens/
    │   └── cart_screen.dart
    ├── views/
    │   ├── cart_view_factory.dart
    │   ├── cart_loading_view.dart
    │   ├── cart_loaded_view.dart
    │   ├── cart_error_view.dart
    │   ├── cart_empty_view.dart
    │   └── guest_cart_view.dart
    ├── widgets/
    │   ├── cart_item.dart
    │   ├── cart_summary.dart
    │   └── cart_items_list.dart
    └── listeners/
        └── cart_listener.dart
```

## Data Flow

1. **Screen** – Provides BlocProvider, contains BlocBuilder/BlocListener.
2. **View Factory** – Reads Cubit state, returns the appropriate View (loading/loaded/error).
3. **View** – Renders UI. Calls Cubit methods (e.g. `context.read<CartCubit>().addToCart(...)`).
4. **Listener** – BlocListener that shows snackbars or toasts on success/error.
5. **Cubit** – Calls UseCases, emits new states.
6. **UseCase** – Calls Repository, returns `Result<T>`.
7. **Repository** – Calls DataSource, maps models to entities, handles failures.
