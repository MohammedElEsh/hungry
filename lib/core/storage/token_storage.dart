import 'secure_storage.dart';

/// Dedicated storage for auth token. Uses [SecureStorage] under the hood
/// so the rest of the app does not depend on flutter_secure_storage directly.
abstract class TokenStorage {
  static const String tokenKey = 'auth_token';

  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
}

/// Default implementation that delegates to [SecureStorage].
class TokenStorageImpl implements TokenStorage {
  TokenStorageImpl(this._storage);

  final SecureStorage _storage;

  @override
  Future<void> saveToken(String token) => _storage.write(TokenStorage.tokenKey, token);

  @override
  Future<String?> getToken() => _storage.read(TokenStorage.tokenKey);

  @override
  Future<void> deleteToken() => _storage.delete(TokenStorage.tokenKey);
}
