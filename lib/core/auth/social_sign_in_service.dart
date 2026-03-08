import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// Obtains idToken from platform-specific social sign-in (Google, Apple).
abstract class SocialSignInService {
  Future<String> signInWithGoogle();
  Future<String> signInWithApple();
}

class SocialSignInServiceImpl implements SocialSignInService {
  @override
  Future<String> signInWithGoogle() async {
    final account = await GoogleSignIn.instance.authenticate(
      scopeHint: ['email'],
    );
    final auth = account.authentication;
    final idToken = auth.idToken;
    if (idToken == null || idToken.isEmpty) {
      throw SocialSignInException('No idToken from Google');
    }
    return idToken;
  }

  @override
  Future<String> signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final idToken = credential.identityToken;
    if (idToken == null || idToken.isEmpty) {
      throw SocialSignInException('No idToken from Apple');
    }
    return idToken;
  }
}

class SocialSignInException implements Exception {
  final String message;
  SocialSignInException(this.message);
  @override
  String toString() => message;
}

class SocialSignInCancelledException implements Exception {
  final String message;
  SocialSignInCancelledException(this.message);
  @override
  String toString() => message;
}
