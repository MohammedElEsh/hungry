# Core Structure

This document describes each folder under `lib/core/` and its responsibilities. Use it when adding shared code or locating utilities.

## core/ Overview

| Folder | Purpose | Key Files |
|--------|---------|-----------|
| analytics | App analytics and event tracking | analytics_service.dart, analytics_service_impl.dart |
| auth | Social sign-in helpers | social_sign_in_service.dart |
| cache | In-memory or persistent cache | cache_store.dart, cache_store_impl.dart |
| components | Shared UI components (buttons, bars) | custom_button.dart, custom_bottom_nav_bar.dart |
| constants | App-wide constants | api_endpoints.dart, app_colors.dart, app_strings.dart |
| di | Dependency injection setup | injection.dart |
| domain | Shared domain types | result.dart, failures.dart |
| error | Exceptions and failure re-exports | exceptions.dart, failures.dart |
| hive | Hive setup and box definitions | hive_manager.dart, hive_boxes.dart |
| interceptors | Dio interceptors | auth_interceptor.dart, logging_interceptor.dart |
| logger | App logging (debug/release) | app_logger.dart, app_logger_interface.dart |
| network | HTTP client and connectivity | dio_client.dart, network_info.dart, token_provider.dart |
| notifications | Local notifications | notification_service.dart |
| router | Route-related helpers | auth_refresh_notifier.dart, analytics_route_observer.dart |
| storage | Persistence abstractions | secure_storage.dart, app_preferences.dart, token_storage.dart |
| theme | Theming and typography | app_theme.dart, text_styles.dart, theme_notifier.dart |
| utils | Routing, validators, helpers | app_router.dart, alerts.dart, validators.dart |
| widgets | Shared UI widgets | loading_indicator.dart, error_display_widget.dart |
| animations | Reusable animations | fade_in.dart, slide_in.dart |

## Folder Details

### analytics/

- **analytics_service.dart** – Abstract interface for logging events and user ID.
- **analytics_service_impl.dart** – Implementation (e.g. Sentry, Firebase Analytics).

Use for: `logEvent`, `setUserId`, screen tracking.

### auth/

- **social_sign_in_service.dart** – Wraps `GoogleSignIn` and `SignInWithApple`. Returns ID token for backend exchange.

Use for: Login/Signup screens with social buttons.

### cache/

- **cache_store.dart** – Abstract key-value cache (get, set, delete).
- **cache_store_impl.dart** – In-memory implementation.

Use for: Caching API responses (e.g. categories, products).

### components/

- **custom_button.dart** – Reusable primary/secondary button.
- **custom_bottom_nav_bar.dart** – Bottom navigation (Home, Cart, Orders, Profile).
- **profile_text_field.dart** – Styled text field for profile forms.

Use for: Buttons, navigation bars, shared form fields.

### constants/

- **api_endpoints.dart** – Base URL and endpoint paths (login, register, products, etc.).
- **app_colors.dart** – Color palette.
- **app_strings.dart** – App-wide string constants.
- **app_links.dart** – Deep link or external URLs.

Use for: Centralized configuration, avoiding magic strings.

### di/

- **injection.dart** – GetIt registration for all services, repositories, use cases, Cubits. Call `init()` from `main.dart` before `runApp`.

### domain/

- **result.dart** – `Result<T>` sealed class (`Success`, `FailureResult`).
- **failures.dart** – Failure types: `NetworkFailure`, `ServerFailure`, `CacheFailure`, `AuthFailure`, `UnimplementedFailure`.

Use for: All use case return types. Import via `core/domain/result.dart` and `core/error/failures.dart`.

### error/

- **failures.dart** – Re-exports `core/domain/failures.dart`.
- **exceptions.dart** – `ServerException`, `NetworkException`, `AuthException` for data layer.

### hive/

- **hive_manager.dart** – Hive initialization and box registration.
- **hive_boxes.dart** – Box name constants.

Use for: Local storage (e.g. AppPreferences implementation).

### interceptors/

- **auth_interceptor.dart** – Adds `Authorization: Bearer <token>` to requests.
- **logging_interceptor.dart** – Logs request/response for debugging.

Attached to Dio in `DioClient`.

### logger/

- **app_logger_interface.dart** – Abstract interface (d, i, w, e).
- **app_logger.dart** – Static facade (e.g. `AppLogger.e(...)`).
- **app_logger_impl.dart** – Implementation using debugPrint / Sentry.

### network/

- **dio_client.dart** – Dio instance with base URL and interceptors.
- **network_info.dart** – Connectivity check (via connectivity_plus).
- **token_provider.dart** – Holds token in memory for AuthInterceptor.
- **api_exceptions.dart** – Maps DioException to ServerException, etc.
- **api_error.dart** – Simple error with message (legacy).
- **api_service.dart** – Generic get/post/put/delete wrapper over Dio.

### notifications/

- **notification_service.dart** – Abstract interface for local notifications.
- **notification_service_impl.dart** – Uses flutter_local_notifications.

### router/

- **auth_refresh_notifier.dart** – ChangeNotifier. Call `notifyAuthChanged()` when login/logout. Passed to GoRouter as `refreshListenable`.
- **analytics_route_observer.dart** – Logs route changes for analytics.

### storage/

- **secure_storage.dart** – Abstract read/write/delete for sensitive data.
- **secure_storage_impl.dart** – Uses flutter_secure_storage.
- **token_storage.dart** – Wrapper for auth token only.
- **app_preferences.dart** – Abstract locale, theme, guest mode, onboarding.
- **app_preferences_impl.dart** – Hive-backed implementation.

Use for: Token in TokenStorage; everything else in AppPreferences.

### theme/

- **app_theme.dart** – Light and dark ThemeData.
- **text_styles.dart** – Typography (AppTextStyles).
- **theme_notifier.dart** – ChangeNotifier for theme mode.
- **app_spacing.dart** – Spacing constants (responsive).

### utils/

- **app_router.dart** – GoRouter config, route constants (kLoginView, kHomeView, etc.), redirect logic.
- **alerts.dart** – Snackbar / banner helpers.
- **validators.dart** – Email, password validators.
- **formatters.dart** – Date, price formatters.
- **helpers.dart** – Misc helpers.
- **assets.dart** – Asset paths.
- **styles.dart** – Text styles (legacy; prefer text_styles.dart).

### widgets/

- **loading_indicator.dart** – Loading spinner.
- **error_display_widget.dart** – Error message + retry button.
- **empty_state_widget.dart** – Empty list placeholder.
- **empty_cart_widget.dart** – Empty cart specific.
- **skeleton_loading.dart** – Skeleton placeholder.
- **offline_banner.dart** – Offline notice.
- **terms_privacy_links.dart** – Terms & Privacy links.

### animations/

- **fade_in.dart** – Fade-in animation.
- **slide_in.dart** – Slide-in animation.
