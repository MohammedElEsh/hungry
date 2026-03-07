import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'secure_storage.dart';

/// Secure storage implementation using platform keychain/keystore.
class SecureStorageImpl implements SecureStorage {
  SecureStorageImpl({AndroidOptions? androidOptions, IOSOptions? iosOptions})
      : _storage = FlutterSecureStorage(
          aOptions: androidOptions ??
              const AndroidOptions(
                encryptedSharedPreferences: true,
              ),
          iOptions: iosOptions ?? const IOSOptions(),
        );

  final FlutterSecureStorage _storage;

  @override
  Future<void> write(String key, String value) => _storage.write(key: key, value: value);

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> delete(String key) => _storage.delete(key: key);
}
