---
name: Hungry App Full Upgrade
overview: "A phased plan to upgrade the Hungry Flutter app into a production-ready, scalable template: secure auth storage, unified Result/Failure, refactored auth layer, app logger, error handling, protected routing, design system, responsive UI, i18n with RTL, testing, deep links, CI/CD, crash reporting, and analytics."
todos: []
isProject: false
---

# Hungry App – Full Upgrade Plan

This plan turns the app into a reusable, production-ready template. Work is split into phases so you can implement and test incrementally. All paths below are under the project root unless noted.

---

## Phase 1: Foundation (Core & Auth)

### 1.1 Secure storage for auth token

- Add dependency: `flutter_secure_storage` in [pubspec.yaml](pubspec.yaml).
- Create an abstraction in core (e.g. `lib/core/storage/secure_storage.dart`):
  - Interface: `abstract class SecureStorage { Future<void> write(String key, String value); Future<String?> read(String key); Future<void> delete(String key); }`
  - Implementation using `FlutterSecureStorage()` for token (and optionally other secrets).
- Create a dedicated token storage wrapper (e.g. `TokenStorage` or extend the interface) used only for auth token so the rest of the app does not depend on secure_storage directly.
- Register in [lib/core/di/injection.dart](lib/core/di/injection.dart) and inject into whoever currently persists/reads the token (see 1.2).
- Replace all token read/write/delete in [lib/core/utils/pref_helper.dart](lib/core/utils/pref_helper.dart) (and any direct `PrefHelper` token usage) with the new secure storage. Keep `PrefHelper` for non-sensitive data only (e.g. `guest_mode`, locale, theme).

**Files to touch:** `pubspec.yaml`, new `lib/core/storage/secure_storage.dart` (interface + impl), `lib/core/di/injection.dart`, [lib/core/utils/pref_helper.dart](lib/core/utils/pref_helper.dart), [lib/features/auth/data/repositories/auth_repository_impl.dart](lib/features/auth/data/repositories/auth_repository_impl.dart), [lib/features/auth/data/repositories/auth_repo.dart](lib/features/auth/data/repositories/auth_repo.dart), [lib/main.dart](lib/main.dart) (read token at startup from new storage).

### 1.2 Unify Result and Failure in core

- Keep [lib/core/domain/result.dart](lib/core/domain/result.dart) and [lib/core/domain/failures.dart](lib/core/domain/failures.dart) as the single source of truth. Add any missing failure types (e.g. `ValidationFailure`) in core if needed.
- Remove duplicate definitions:
  - Delete [lib/features/orders/domain/result.dart](lib/features/orders/domain/result.dart), [lib/features/orders/domain/failures.dart](lib/features/orders/domain/failures.dart).
  - Delete [lib/features/product/domain/result.dart](lib/features/product/domain/result.dart), [lib/features/product/domain/failures.dart](lib/features/product/domain/failures.dart).
  - Delete [lib/features/profile/domain/result.dart](lib/features/profile/domain/result.dart), [lib/features/profile/domain/failures.dart](lib/features/profile/domain/failures.dart).
- Update all imports in features to use core:
  - `import 'package:hungry/core/domain/result.dart';` and `import 'package:hungry/core/error/failures.dart';` (or `core/domain/failures.dart` if that’s the canonical export).
- Ensure [lib/core/error/failures.dart](lib/core/error/failures.dart) only re-exports from `core/domain/failures.dart` so there is one place for failure types.

### 1.3 Auth layer: single source of truth and DI

- **Goal:** One place for “current user / is logged in / is guest” used by splash, router, profile, checkout. Prefer making this injectable and testable.
- **Option A (minimal change):** Keep `AuthRepo` as the concrete “session” holder but:
  - Introduce an interface in core or auth domain, e.g. `CurrentUserStore` or `AuthStateSource`, with methods like `UserModel? get currentUser`, `bool get isLoggedIn`, `bool get isGuest`, `Future<void> setUserAfterLogin(...)`, `Future<void> clearSession()`.
  - Make `AuthRepo` implement this interface and remove its singleton/static usage: get it only via GetIt in [lib/core/di/injection.dart](lib/core/di/injection.dart).
  - Inject this interface into: [lib/features/auth/data/repositories/auth_repository_impl.dart](lib/features/auth/data/repositories/auth_repository_impl.dart) (to call setUserAfterLogin), [lib/features/profile/data/repositories/profile_repository_impl.dart](lib/features/profile/data/repositories/profile_repository_impl.dart), splash, checkout, and router (for redirect).
- **Option B (full clean):** Move “current user” state into a dedicated service (e.g. `AuthStateRepository` or `SessionRepository`) that uses secure storage + in-memory cache; AuthRepo becomes a thin wrapper over remote auth API and this service. Profile and others depend only on the session service.
- Replace every `AuthRepo()` or `final AuthRepo _authRepo = AuthRepo()` with injected dependency (from GetIt or passed from router/screen). Key files: [lib/splash/presentation/views/splash_view.dart](lib/splash/presentation/views/splash_view.dart), [lib/features/checkout/presentation/screens/checkout_screen.dart](lib/features/checkout/presentation/screens/checkout_screen.dart), [lib/features/profile/data/repositories/profile_repository_impl.dart](lib/features/profile/data/repositories/profile_repository_impl.dart), [lib/features/auth/data/repositories/auth_repository_impl.dart](lib/features/auth/data/repositories/auth_repository_impl.dart).
- Ensure token is read at startup from the new secure storage and set on `TokenProvider` (and, if used, on the auth state service).

---

## Phase 2: Error handling and logging

### 2.1 App logger (interface + release reporting)

- In core, define an abstract logger (e.g. `lib/core/logger/app_logger.dart`): `abstract class AppLogger { void d(String msg, [Object? e, StackTrace? st]); void i(String msg); void w(String msg); void e(String msg, [Object? e, StackTrace? st]); }`.
- Implement a default implementation: debug builds use `debugPrint`; release builds for `e` (and optionally `w`) call a callback or send to a crash reporter (see Phase 6). Do not log sensitive data (tokens, passwords).
- Register the logger in DI; use it in interceptors, repositories, and cubits instead of `print`/`debugPrint`. Replace the current static [lib/core/logger/app_logger.dart](lib/core/logger/app_logger.dart) with this injectable logger so tests can use a no-op or mock.

### 2.2 Global error handling

- In [lib/main.dart](lib/main.dart) (or a `bootstrap.dart` called from main):
  - Set `FlutterError.onError` to log (via AppLogger) and, in release, forward to crash reporting.
  - Wrap `runApp(...)` in `runZonedGuarded` and in the error callback log and forward uncaught async errors to the same crash reporter.
- Ensure Bloc/Cubit async flows do not swallow exceptions: either return `Result.failure` from use cases or catch and emit an error state so the UI can show a message.

---

## Phase 3: Router, protected routes, and deep links

### 3.1 Protected routes and redirect

- In [lib/core/utils/app_router.dart](lib/core/utils/app_router.dart), add a `redirect` to `GoRouter`:
  - If the current location is a protected route (everything except `/` and `/homeView` and possibly `/loginView`, `/signupView`) and the user is not logged in and not guest, redirect to `/loginView`.
  - If the user is logged in (or guest) and goes to `/loginView` or `/signupView`, redirect to `/homeView`.
- Use a `RefreshListenable` (e.g. a simple `ChangeNotifier` that notifies when auth state changes) and pass it to `GoRouter(..., refreshListenable: authNotifier)`. When login/logout/guest toggle happens, call `authNotifier.notifyListeners()` so the router re-evaluates redirect.
- Implement “is logged in or guest” by reading from the injectable auth state source (from Phase 1.3); the listenable can hold a reference to it and call `notifyListeners` after any state change.

### 3.2 Deep links

- Document and use path/query conventions that already work with [lib/core/utils/app_router.dart](lib/core/utils/app_router.dart) (e.g. `/productView?id=123` or path `/productView/:id`). Ensure product and order screens read `state.uri.queryParameters['id']` or path parameters.
- Add Android and iOS configuration for App Links / Universal Links (assetlinks.json, apple-app-site-association) if you have a domain; otherwise document that deep links work with custom scheme (e.g. `hungry://product/123`). Optionally add package `app_links` and in `main` parse initial URI and navigate via `context.go` to the matching route.

---

## Phase 4: Design system and responsive UI

### 4.1 Design system (spacing, typography, components)

- **Spacing:** Add `lib/core/theme/app_spacing.dart` (or under `constants/`) with responsive values using ScreenUtil, e.g. `AppSpacing.xs = 4.r`, `sm = 8.r`, `md = 16.r`, `lg = 24.r`, `xl = 32.r`. Use these in padding/gaps across the app.
- **Typography:** Refactor [lib/core/utils/styles.dart](lib/core/utils/styles.dart) (or [lib/core/theme/text_styles.dart](lib/core/theme/text_styles.dart)) so all `fontSize` values use `.sp` (e.g. via ScreenUtil). Ensure text styles are built in a context where ScreenUtil is already initialized (e.g. inside `ScreenUtilInit` builder or using a function that takes context). This makes typography scale on different devices and respect system font size.
- **Components:** Ensure [lib/core/components/custom_button.dart](lib/core/components/custom_button.dart) and shared form fields use design system spacing and, where applicable, responsive heights/widths (e.g. `56.h`, `0.9.sw`). Document usage in a short README or comment in the design system folder.

### 4.2 Responsive layout and SafeArea

- Audit all screens and replace fixed numeric padding/margins with ScreenUtil (`.w`, `.h`, `.r`) or design system spacing. Replace fixed `fontSize` with `.sp` where still hardcoded.
- Wrap top-level screen content (or scaffold body) with `SafeArea` where needed so content is not drawn under status bar, notch, or home indicator. Pay special attention to [lib/features/auth/presentation/views/login_form_view.dart](lib/features/auth/presentation/views/login_form_view.dart), splash, home, and checkout.
- Keep [lib/main.dart](lib/main.dart) `ScreenUtilInit` with `designSize: Size(375, 812)` and `minTextAdapt: true`, `splitScreenMode: true`. Optionally add a note in code that small devices (< 360 width) may need reduced padding if needed later.

---

## Phase 5: Internationalization (i18n) and RTL

### 5.1 Setup and translation files

- Add `flutter_localizations` and a localization package (e.g. `easy_local` or Flutter’s built-in `flutter_localizations` + `intl`). If using `easy_local`: add dependency, wrap app with `EasyLocalization`, and create `assets/translations/ar.json` and `assets/translations/en.json`.
- Define keys for all user-visible strings (login, signup, home, cart, checkout, profile, errors, buttons). Replace hardcoded strings in UI with lookup via context (e.g. `context.tr('key')` or `AppLocalizations.of(context)!.key`).
- Store the selected locale in PrefHelper (or a settings repo) and apply it on app startup so the app opens in the user’s last chosen language.

### 5.2 RTL and direction

- Set `MaterialApp` (or root widget) `locale` and `supportedLocales` from the localization package. For RTL, ensure `Directionality` is driven by locale (e.g. `locale.languageCode == 'ar'` → `TextDirection.rtl`). Many packages set this automatically from the locale.
- Test layout on a few key screens (login, home, profile) in both Arabic and English to ensure RTL flips correctly and no alignment issues.

---

## Phase 6: Crash reporting and analytics (no Firebase)

### 6.1 Crash reporting

- Choose a service (e.g. **Sentry**). Add `sentry_flutter` (or equivalent) in [pubspec.yaml](pubspec.yaml).
- In `main.dart`, initialize the SDK (with DSN from env or config). In the same place, when setting `FlutterError.onError` and `runZonedGuarded` error callback, forward errors and stack traces to Sentry (e.g. `Sentry.captureException`). Ensure no sensitive data is attached.
- Optionally attach user ID (not token) to Sentry after login so reports can be grouped by user.

### 6.2 Analytics

- Choose a provider (e.g. **Mixpanel**, **Amplitude**, or **PostHog**). Add the corresponding Flutter package.
- Create an `AnalyticsService` (interface in core, implementation in data or core) with methods like `logEvent(String name, [Map<String, dynamic>? params])`, `setUserId(String? id)`. Register in DI.
- Call `logEvent` from key flows: screen views (e.g. route name when route changes), add to cart, start checkout, order placed, login, signup. Do not send PII in event params; use IDs where needed.

---

## Phase 7: Testing

### 7.1 Unit tests

- **Use cases:** For at least one use case per feature (e.g. `LoginUseCase`, `GetCartItemsUseCase`), write tests that mock the repository and assert that success/failure results are returned as expected. Use `mocktail` for mocks.
- **Repositories:** For one or two repo implementations (e.g. `AuthRepositoryImpl`, `CartRepositoryImpl`), mock the data source and network info and assert that exceptions are mapped to the correct `Failure` and success to `Success`.
- **Cubits:** For at least `AuthCubit` and `CartCubit`, use `bloc_test` to emit expected states when the underlying use case returns success or failure.
- Place tests under `test/` (e.g. `test/features/auth/domain/usecases/login_usecase_test.dart`, `test/features/auth/presentation/cubit/auth_cubit_test.dart`). Run with `flutter test`.

### 7.2 Widget tests

- Replace the default [test/widget_test.dart](test/widget_test.dart) with at least one widget test for a real screen (e.g. login form: pump widget, enter text, tap submit, verify that a loading or error state is shown or that a callback is invoked). Use `tester.pumpWidget` with necessary `MaterialApp` and providers (BlocProvider, etc.).

### 7.3 Integration tests

- Add `integration_test/app_test.dart` (or similar). Use `IntegrationTestWidgetsFlutterBinding.ensureInitialized()`, then pump the app (e.g. `runApp(MyApp())` with router), and simulate a minimal flow: e.g. tap “Login”, fill email/password (or use test credentials from env), submit, then assert that the app navigates to home or shows a specific widget. Run with `flutter test integration_test/`.

### 7.4 Documentation for you

- Add a short `docs/TESTING.md` (or a section in README): how to run `flutter test` and `flutter test integration_test/`, how to add a new unit test (with one example), and how mocks are structured (mock repository → use case → expected result).

---

## Phase 8: CI/CD

- Create `.github/workflows/flutter_ci.yml` (or equivalent for your repo host):
  1. Checkout, set up Flutter (use a stable version), run `flutter pub get`, `flutter analyze`, `flutter test`.
  2. Optionally add a job to build APK (`flutter build apk --release`) and upload the artifact.
- No secrets in the workflow file; use environment variables or GitHub Secrets for any API keys (e.g. Sentry DSN) if you add build-time config later.

---

## Phase 9: Cleanup and optional enhancements

### 9.1 Remove dev credentials and hardcoded values

- In [lib/features/auth/presentation/screens/login_screen.dart](lib/features/auth/presentation/screens/login_screen.dart), remove the pre-filled email/password in `initState`, or guard with `kDebugMode` so they appear only in debug builds.

### 9.2 Social login (backend-dependent)

- Add packages `google_sign_in` and `sign_in_with_apple`. Create use cases `LoginWithGoogleUseCase` and `LoginWithAppleUseCase` that call the sign-in SDK, then send the received token/credential to your backend (via a new endpoint or existing auth endpoint). Backend returns the app token; app stores it in secure storage and updates auth state. Add UI buttons on login/signup screens. If the third-party API does not support social yet, implement the client-side flow and document the required backend contract so it can be added later.

### 9.3 Code generation (optional, incremental)

- Add `freezed`, `json_serializable`, `injectable` (and `injectable_generator` / `build_runner`) as dev dependencies. Gradually convert entities and models to use `@freezed` and `@JsonSerializable`; run `dart run build_runner build` and fix imports. Optionally replace manual GetIt registration in [lib/core/di/injection.dart](lib/core/di/injection.dart) with `@injectable` and generated `configureDependencies()`. This reduces boilerplate and improves consistency; do one feature at a time to avoid big-bang refactors.

---

## Implementation order summary


| Order | Phase           | Delivers                                                             |
| ----- | --------------- | -------------------------------------------------------------------- |
| 1     | 1.1 + 1.2 + 1.3 | Secure token storage, single Result/Failure, single auth source + DI |
| 2     | 2.1 + 2.2       | App logger interface + release hook, global error handling           |
| 3     | 3.1 + 3.2       | Protected routes + redirect, deep link support                       |
| 4     | 4.1 + 4.2       | Design system (spacing, typography), responsive + SafeArea           |
| 5     | 5.1 + 5.2       | i18n (ar/en), RTL                                                    |
| 6     | 6.1 + 6.2       | Sentry (or similar), analytics service + events                      |
| 7     | 7.1–7.4         | Unit, widget, integration tests + TESTING.md                         |
| 8     | 8               | GitHub Actions (analyze, test, optional build)                       |
| 9     | 9.1–9.3         | Remove dev credentials, social login, optional code gen              |


---

## Dependency summary (add to pubspec.yaml)

- **Production:** `flutter_secure_storage`, `sentry_flutter` (or chosen crash reporter), analytics package (e.g. `mixpanel_flutter` or `posthog_flutter`), localization (e.g. `easy_local`), and for social login `google_sign_in`, `sign_in_with_apple`. Optional: `app_links` for deep links.
- **Dev:** Already have `mocktail`, `bloc_test`, `build_runner`. Optional: `freezed`, `json_serializable`, `injectable`, `injectable_generator`.

No Firebase is required; crash reporting and analytics are handled by the chosen third-party services.