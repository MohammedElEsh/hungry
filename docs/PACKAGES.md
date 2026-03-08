# Packages

This document lists the dependencies used in Hungry, grouped by category. Use it as a reference when setting up a new project or adding functionality.

## Dependencies (pubspec.yaml)

| Category | Package | Version | Purpose |
|----------|---------|---------|---------|
| **Networking** | dio | ^5.9.2 | HTTP client for API calls. Supports interceptors, timeouts, and error handling. |
| **State Management** | flutter_bloc | ^9.1.1 | Bloc/Cubit pattern for reactive state management. |
| | equatable | ^2.0.8 | Value equality for state classes. Reduces rebuilds when state hasn't changed. |
| **DI** | get_it | ^9.2.1 | Service locator and dependency injection. Register services once, inject everywhere. |
| **Routing** | go_router | ^17.1.0 | Declarative routing with deep links, redirects, and nested navigation. |
| **Storage** | shared_preferences | ^2.5.4 | Key-value store for simple preferences (legacy; prefer AppPreferences/Hive). |
| | flutter_secure_storage | ^10.0.0 | Encrypted storage for tokens and sensitive data. |
| | hive | ^2.2.3 | Fast local NoSQL database. |
| | hive_flutter | ^1.1.0 | Hive integration for Flutter (path, async init). |
| | connectivity_plus | ^7.0.0 | Check network connectivity before API calls. |
| **Localization** | flutter_localizations | sdk | Flutter built-in localizations. |
| | easy_localization | ^3.0.8 | JSON-based translations, RTL support, locale switching. |
| **UI & Design** | cupertino_icons | ^1.0.8 | Cupertino-style icons. |
| | google_fonts | ^8.0.2 | Google Fonts for typography. |
| | font_awesome_flutter | ^10.12.0 | Font Awesome icons. |
| | gap | ^3.0.1 | Spacing widgets (Gap) instead of SizedBox. |
| | flutter_screenutil | ^5.9.3 | Responsive sizing (.w, .h, .sp, .r). |
| | skeletonizer | ^2.1.3 | Skeleton loading placeholders. |
| | alert_banner | ^1.0.1 | Banner-style alerts. |
| **Crash & Analytics** | sentry_flutter | ^9.14.0 | Crash reporting and error tracking in production. |
| **Auth (Social)** | google_sign_in | ^7.2.0 | Google Sign-In. Backend must exchange ID token for app token. |
| | sign_in_with_apple | ^7.0.1 | Sign in with Apple. |
| **Media** | image_picker | ^1.2.1 | Pick images from camera or gallery. |
| | cached_network_image | ^3.4.1 | Cache and display network images. |
| **Other** | flutter_local_notifications | ^18.0.1 | Local notifications (order status, etc.). |
| | url_launcher | ^6.3.1 | Open URLs, phone, email in external apps. |

## Dev Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| flutter_test | sdk | Unit and widget tests. |
| integration_test | sdk | End-to-end tests on device/emulator. |
| flutter_lints | ^6.0.0 | Recommended Dart/Flutter linter rules. |
| flutter_launcher_icons | ^0.14.4 | Generate app launcher icons. |
| build_runner | ^2.12.2 | Code generation (e.g. Hive adapters). |
| mocktail | ^1.0.4 | Mocking for unit tests (no code generation). |
| bloc_test | ^10.0.0 | Test Bloc/Cubit emissions. |

## When to Use Each Package

- **dio** – All HTTP requests. Wrap with `DioClient` and `AuthInterceptor`.
- **flutter_bloc / equatable** – Every feature with state. Use Cubit for simpler flows.
- **get_it** – Register all repositories, use cases, Cubits, and shared services.
- **go_router** – Replace Navigator.push with `context.go`, `context.push`. Use `redirect` for auth guards.
- **flutter_secure_storage** – Store auth token. Use via `TokenStorage` abstraction.
- **hive** – Cache, preferences (via `AppPreferences` implementation). Not for tokens.
- **connectivity_plus** – Check before API calls to avoid silent failures. Use via `NetworkInfo`.
- **easy_localization** – All user-facing strings. Use `'key'.tr()` and `context.locale`.
- **flutter_screenutil** – Use `.w`, `.h`, `.sp`, `.r` for responsive layouts. Call `ScreenUtilInit` in `main`.
- **sentry_flutter** – Wrap `runApp` and set `FlutterError.onError` to capture crashes.
