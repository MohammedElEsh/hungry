/// Abstraction for secure key-value storage (e.g. encrypted).
/// Use for tokens and other sensitive data.
abstract class SecureStorage {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
  Future<void> delete(String key);
}
