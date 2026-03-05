import '../../../../core/domain/result.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/network/token_provider.dart';
import '../../../../core/utils/pref_helper.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import 'auth_repo.dart';

/// Auth repository implementation - remote only; token persisted via PrefHelper.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  final NetworkInfo _networkInfo;
  final TokenProvider _tokenProvider;
  final AuthRepo _authRepo;

  AuthRepositoryImpl(
    this._remote,
    this._networkInfo,
    this._tokenProvider,
    this._authRepo,
  );

  @override
  Future<Result<UserEntity>> login(String email, String password) async {
    if (!await _networkInfo.isConnected) {
      return const FailureResult(NetworkFailure());
    }
    try {
      final user = await _remote.login(email, password);
      if (user.token != null && user.token!.isNotEmpty) {
        await PrefHelper.saveToken(user.token!);
        await PrefHelper.setGuestMode(false);
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
        await PrefHelper.saveToken(user.token!);
        await PrefHelper.setGuestMode(false);
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
    await PrefHelper.removeToken();
    _tokenProvider.clearToken();
    return const Success(null);
  }

  @override
  Future<Result<UserEntity?>> getCachedUser() async {
    final token = await PrefHelper.getToken();
    if (token == null || token.isEmpty) return const Success(null);
    _tokenProvider.setToken(token);
    return Success(UserEntity(
      id: '',
      email: '',
      token: token,
    ));
  }
}
