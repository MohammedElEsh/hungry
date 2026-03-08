import '../../../../core/domain/result.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/network/token_provider.dart';
import '../../../../core/storage/app_preferences.dart';
import '../../../../core/storage/token_storage.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import 'auth_repo.dart';

/// Auth repository implementation - remote only; token persisted via [TokenStorage].
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  final NetworkInfo _networkInfo;
  final TokenProvider _tokenProvider;
  final TokenStorage _tokenStorage;
  final AuthRepo _authRepo;
  final AppPreferences _appPreferences;

  AuthRepositoryImpl(
    this._remote,
    this._networkInfo,
    this._tokenProvider,
    this._tokenStorage,
    this._authRepo,
    this._appPreferences,
  );

  @override
  Future<Result<UserEntity>> login(String email, String password) async {
    if (!await _networkInfo.isConnected) {
      return const FailureResult(NetworkFailure());
    }
    try {
      final user = await _remote.login(email, password);
      if (user.token != null && user.token!.isNotEmpty) {
        await _tokenStorage.saveToken(user.token!);
        await _appPreferences.setGuestMode(false);
        _tokenProvider.setToken(user.token!);
        _authRepo.setUserFromLogin(user);
      }
      return Success(user);
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    }
  }

  @override
  Future<Result<UserEntity>> register(
      String email, String password, String name) async {
    if (!await _networkInfo.isConnected) {
      return const FailureResult(NetworkFailure());
    }
    try {
      final user = await _remote.register(email, password, name);
      if (user.token != null && user.token!.isNotEmpty) {
        await _tokenStorage.saveToken(user.token!);
        await _appPreferences.setGuestMode(false);
        _tokenProvider.setToken(user.token!);
        _authRepo.setUserFromLogin(user);
      }
      return Success(user);
    } on ServerException catch (e) {
      return FailureResult(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    } on AuthException catch (e) {
      return FailureResult(AuthFailure(e.message));
    }
  }

  @override
  Future<Result<void>> logout() async {
    await _tokenStorage.deleteToken();
    _tokenProvider.clearToken();
    return const Success(null);
  }

  @override
  Future<Result<UserEntity>> loginWithGoogle(String idToken) async {
    if (!await _networkInfo.isConnected) {
      return const FailureResult(NetworkFailure());
    }
    try {
      final user = await _remote.loginWithGoogle(idToken);
      if (user.token != null && user.token!.isNotEmpty) {
        await _tokenStorage.saveToken(user.token!);
        await _appPreferences.setGuestMode(false);
        _tokenProvider.setToken(user.token!);
        _authRepo.setUserFromLogin(user);
      }
      return Success(user);
    } on ServerException catch (e) {
      if (e.message.contains('will be available') ||
          e.message.contains('not available')) {
        return FailureResult(UnimplementedFailure(e.message));
      }
      return FailureResult(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    }
  }

  @override
  Future<Result<UserEntity>> loginWithApple(String idToken) async {
    if (!await _networkInfo.isConnected) {
      return const FailureResult(NetworkFailure());
    }
    try {
      final user = await _remote.loginWithApple(idToken);
      if (user.token != null && user.token!.isNotEmpty) {
        await _tokenStorage.saveToken(user.token!);
        await _appPreferences.setGuestMode(false);
        _tokenProvider.setToken(user.token!);
        _authRepo.setUserFromLogin(user);
      }
      return Success(user);
    } on ServerException catch (e) {
      if (e.message.contains('will be available') ||
          e.message.contains('not available')) {
        return FailureResult(UnimplementedFailure(e.message));
      }
      return FailureResult(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    }
  }

  @override
  Future<Result<void>> requestPasswordResetOtp(String email) async {
    if (!await _networkInfo.isConnected) {
      return const FailureResult(NetworkFailure());
    }
    try {
      await _remote.requestPasswordResetOtp(email);
      return const Success(null);
    } on ServerException catch (e) {
      if (e.message.contains('will be available')) {
        return FailureResult(UnimplementedFailure(e.message));
      }
      return FailureResult(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    }
  }

  @override
  Future<Result<void>> resetPasswordWithOtp(String email, String otp, String newPassword) async {
    if (!await _networkInfo.isConnected) {
      return const FailureResult(NetworkFailure());
    }
    try {
      await _remote.resetPasswordWithOtp(email, otp, newPassword);
      return const Success(null);
    } on ServerException catch (e) {
      if (e.message.contains('will be available')) {
        return FailureResult(UnimplementedFailure(e.message));
      }
      return FailureResult(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return FailureResult(NetworkFailure(e.message));
    }
  }

  @override
  Future<Result<UserEntity?>> getCachedUser() async {
    final token = await _tokenStorage.getToken();
    if (token == null || token.isEmpty) return const Success(null);
    _tokenProvider.setToken(token);
    return Success(UserEntity(
      id: '',
      email: '',
      token: token,
    ));
  }
}
