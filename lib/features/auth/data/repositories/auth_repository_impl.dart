import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/domain/result.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/network/token_provider.dart';
import '../../../../core/router/auth_refresh_notifier.dart';
import '../../../../core/storage/app_preferences.dart';
import '../../../../core/storage/token_storage.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

/// Auth repository implementation - single source of auth/session state.
/// Handles login, profile, auto-login, guest mode, and logout.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  final NetworkInfo _networkInfo;
  final TokenProvider _tokenProvider;
  final TokenStorage _tokenStorage;
  final ApiService _apiService;
  final AuthRefreshNotifier _authRefreshNotifier;
  final AppPreferences _appPreferences;

  bool _isGuest = false;
  UserModel? _currentUser;

  AuthRepositoryImpl(
    this._remote,
    this._networkInfo,
    this._tokenProvider,
    this._tokenStorage,
    this._apiService,
    this._authRefreshNotifier,
    this._appPreferences,
  );

  @override
  UserEntity? get currentUser =>
      _currentUser != null ? _userModelToEntity(_currentUser!) : null;

  /// For ProfileRepositoryImpl and other code that need the full model (e.g. image URL).
  UserModel? get currentUserModel => _currentUser;

  @override
  bool get isLoggedIn => !_isGuest && _currentUser != null;

  @override
  bool get isGuest => _isGuest;

  static UserEntity _userModelToEntity(UserModel m) => UserEntity(
        id: m.id,
        email: m.email,
        name: m.name,
        token: m.token,
        address: m.address,
        visa: m.visa,
        image: m.image,
      );

  static UserModel _userEntityToModel(UserEntity e) => UserModel(
        id: e.id,
        email: e.email,
        name: e.name,
        token: e.token,
        address: e.address,
        visa: e.visa,
        image: e.image,
      );

  void _setUserFromLogin(UserEntity user) {
    _currentUser = _userEntityToModel(user);
    _isGuest = false;
    _authRefreshNotifier.notifyAuthChanged();
  }

  @override
  void updateSessionUser(UserEntity user) {
    _currentUser = _userEntityToModel(user);
    _authRefreshNotifier.notifyAuthChanged();
  }

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
        _setUserFromLogin(user);
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
        _setUserFromLogin(user);
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
    try {
      if (_isGuest) {
        await _tokenStorage.deleteToken();
        _tokenProvider.clearToken();
        await _appPreferences.setGuestMode(false);
      } else {
        await _apiService.post(ApiEndpoints.logout, {});
        await _tokenStorage.deleteToken();
        _tokenProvider.clearToken();
        await _appPreferences.setGuestMode(false);
      }
      _isGuest = false;
      _currentUser = null;
      _authRefreshNotifier.notifyAuthChanged();
      return const Success(null);
    } on ApiError catch (e) {
      // Even if logout API fails, clear local state
      await _tokenStorage.deleteToken();
      _tokenProvider.clearToken();
      await _appPreferences.setGuestMode(false);
      _isGuest = false;
      _currentUser = null;
      _authRefreshNotifier.notifyAuthChanged();
      return FailureResult(ServerFailure(e.message));
    } catch (e) {
      await _tokenStorage.deleteToken();
      _tokenProvider.clearToken();
      await _appPreferences.setGuestMode(false);
      _isGuest = false;
      _currentUser = null;
      _authRefreshNotifier.notifyAuthChanged();
      return FailureResult(ServerFailure(e.toString()));
    }
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
        _setUserFromLogin(user);
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
        _setUserFromLogin(user);
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
  Future<Result<void>> resetPasswordWithOtp(
      String email, String otp, String newPassword) async {
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
    return Success(currentUser ?? UserEntity(id: '', email: '', token: token));
  }

  Future<Result<UserEntity?>> _fetchProfileForAutoLogin() async {
    try {
      final token = await _tokenStorage.getToken();
      if (token == null || token.isEmpty) return Success(currentUser);

      final response = await _apiService.get(ApiEndpoints.profile);
      if (response == null) return Success(currentUser);

      final Map<String, dynamic>? map =
          response is Map ? Map<String, dynamic>.from(response) : null;
      if (map == null || map.isEmpty) return Success(currentUser);

      final data = map['data'];
      Map<String, dynamic> userMap;
      if (data is Map) {
        userMap = Map<String, dynamic>.from(data);
      } else if (map['user'] is Map) {
        userMap = Map<String, dynamic>.from(map['user'] as Map);
      } else if (map['profile'] is Map) {
        userMap = Map<String, dynamic>.from(map['profile'] as Map);
      } else {
        userMap = map;
      }
      if (userMap.isEmpty) return Success(currentUser);

      final user = UserModel.fromJson(userMap);
      final id =
          user.id.isNotEmpty ? user.id : (_currentUser?.id ?? user.email);
      final preservedToken = _currentUser?.token ?? token;
      _currentUser = UserModel(
        id: id,
        email: user.email.isNotEmpty ? user.email : (currentUser?.email ?? ''),
        name: user.name ?? _currentUser?.name,
        token: preservedToken,
        address: user.address ?? _currentUser?.address,
        visa: user.visa ?? _currentUser?.visa,
        image: user.image ?? _currentUser?.image,
      );
      return Success(_currentUser!);
    } on DioException catch (e) {
      final err = ApiExceptions.handleError(e);
      return FailureResult(ServerFailure(err.message));
    } catch (e) {
      if (e is ApiError) return FailureResult(ServerFailure(e.message));
      return FailureResult(ServerFailure(e.toString()));
    }
  }

  @override
  Future<UserEntity?> autoLogin() async {
    try {
      final isGuestMode = await _appPreferences.isGuestMode();
      if (isGuestMode) {
        _isGuest = true;
        _currentUser = null;
        return null;
      }

      final token = await _tokenStorage.getToken();
      if (token == null) return null;

      _tokenProvider.setToken(token);
      final result = await _fetchProfileForAutoLogin();
      return result.when(
        success: (user) {
          if (user != null) {
            _isGuest = false;
            return user;
          }
          return null;
        },
        onFailure: (_) => currentUser,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> continueAsGuest() async {
    await _tokenStorage.deleteToken();
    await _appPreferences.setGuestMode(true);
    _isGuest = true;
    _currentUser = null;
    _authRefreshNotifier.notifyAuthChanged();
  }
}
