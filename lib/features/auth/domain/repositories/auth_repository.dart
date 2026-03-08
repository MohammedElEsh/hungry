import 'package:hungry/core/domain/result.dart';

import '../entities/user_entity.dart';

/// Auth repository contract.
abstract class AuthRepository {
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
}
