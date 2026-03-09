import 'package:hungry/core/domain/result.dart';

import '../entities/user_entity.dart';

/// Auth repository contract.
/// Holds session state and provides auth + profile API.
abstract class AuthRepository {
  UserEntity? get currentUser;
  bool get isLoggedIn;
  bool get isGuest;

  Future<Result<UserEntity>> login(String email, String password);
  Future<Result<UserEntity>> register(
    String email,
    String password,
    String name,
  );
  Future<Result<void>> logout();
  Future<Result<UserEntity?>> getCachedUser();

  Future<Result<UserEntity>> loginWithGoogle(String idToken);
  Future<Result<UserEntity>> loginWithApple(String idToken);

  Future<Result<void>> requestPasswordResetOtp(String email);
  Future<Result<void>> resetPasswordWithOtp(String email, String otp, String newPassword);

  /// Called by ProfileRepositoryImpl when profile is updated so session stays in sync.
  void updateSessionUser(UserEntity user);

  Future<UserEntity?> autoLogin();
  Future<void> continueAsGuest();
}
