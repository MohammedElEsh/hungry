# Social Login (Google / Apple)

Packages `google_sign_in` and `sign_in_with_apple` are included. To enable social login:

1. **Backend:** Your API must accept the social ID token (or auth code) and return the same app token format as email login (e.g. JWT in `data.token`). Add endpoints such as:
   - `POST /auth/google` with body `{ "idToken": "..." }` or `{ "accessToken": "..." }`
   - `POST /auth/apple` with body `{ "idToken": "..." }`, `{ "authorizationCode": "..." }`, or similar

2. **App:** Create `LoginWithGoogleUseCase` and `LoginWithAppleUseCase` that:
   - Call `GoogleSignIn().signIn()` / `SignInWithApple.getAppleCredential()` to get the credential/token
   - Send that to your backend endpoint
   - On success, store the returned app token via `TokenStorage` and update auth state (e.g. `AuthRepo.setUserFromLogin` with the user from the response)

3. **UI:** Add "Sign in with Google" and "Sign in with Apple" buttons on the login/signup screens that call these use cases.

4. **Platform:** Configure Google Sign-In (Android: SHA-1, iOS: URL scheme) and Sign in with Apple (Apple Developer) as per each package's documentation.
