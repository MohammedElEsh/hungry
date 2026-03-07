# Testing Guide

## Running tests

- **Unit and widget tests:** `flutter test`
- **Integration tests:** `flutter test integration_test/`

## Test structure

- `test/` – unit and widget tests
- `test/features/<feature>/` – feature-specific tests (e.g. `domain/usecases/`, `presentation/cubit/`)
- `integration_test/` – end-to-end flows on device/emulator

## Adding a unit test (example: use case)

1. Create a mock for the repository with `mocktail`:
   ```dart
   class MockAuthRepository extends Mock implements AuthRepository {}
   ```
2. In `setUp`, create the use case with the mock.
3. Use `when(() => mock.method(any())).thenAnswer(...)` to stub success or failure.
4. Call the use case and assert on the `Result` (e.g. `expect(result, isA<Success<...>>())`).

## Adding a Cubit test

1. Mock all use cases (and optional dependencies like `AuthRefreshNotifier`, `AnalyticsService`).
2. Use `bloc_test` from package `bloc_test`:
   ```dart
   blocTest<AuthCubit, AuthState>(
     'emits [AuthLoading, AuthLoaded] when login succeeds',
     build: () { ... return cubit; },
     act: (cubit) => cubit.login(...),
     expect: () => [isA<AuthLoading>(), isA<AuthLoaded>()],
   );
   ```

## Adding a widget test

1. Use `testWidgets` and `pumpWidget` with `MaterialApp` (and any required providers).
2. Use `find.text()`, `find.byType()`, `tester.tap()`, `tester.pump()` to interact and assert.

## Adding an integration test

1. Start with `IntegrationTestWidgetsFlutterBinding.ensureInitialized()`.
2. To test the full app, run the real app (e.g. via `integration_test_driver`) or pump a minimal widget tree that matches the flow you need.
3. Use the same `tester` API to tap, fill, and assert on navigation or visible widgets.
