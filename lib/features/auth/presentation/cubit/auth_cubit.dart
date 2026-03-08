import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/analytics/analytics_service.dart';
import '../../../../core/router/auth_refresh_notifier.dart';
import '../../../../core/auth/social_sign_in_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_cached_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/login_with_apple_usecase.dart';
import '../../domain/usecases/login_with_google_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCachedUserUseCase _getCachedUserUseCase;
  final RegisterUseCase _registerUseCase;
  final LoginWithGoogleUseCase _loginWithGoogleUseCase;
  final LoginWithAppleUseCase _loginWithAppleUseCase;
  final SocialSignInService _socialSignInService;
  final AuthRefreshNotifier _authRefreshNotifier;
  final AnalyticsService _analytics;

  AuthCubit(
    this._loginUseCase,
    this._logoutUseCase,
    this._getCachedUserUseCase,
    this._registerUseCase,
    this._loginWithGoogleUseCase,
    this._loginWithAppleUseCase,
    this._socialSignInService,
    this._authRefreshNotifier,
    this._analytics,
  ) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    if (!isClosed) emit(AuthLoading());
    final result = await _loginUseCase(email, password);
    if (isClosed) return;
    result.when(
      success: (user) {
        _authRefreshNotifier.notifyAuthChanged();
        _analytics.logEvent('login');
        _analytics.setUserId(user.id);
        emit(AuthLoaded(user));
      },
      onFailure: (f) => emit(AuthError(f.message)),
    );
  }

  Future<void> register(
      String email, String password, String name) async {
    if (!isClosed) emit(AuthLoading());
    final result = await _registerUseCase(email, password, name);
    if (isClosed) return;
    result.when(
      success: (user) {
        _authRefreshNotifier.notifyAuthChanged();
        _analytics.logEvent('signup');
        _analytics.setUserId(user.id);
        emit(AuthLoaded(user));
      },
      onFailure: (f) => emit(AuthError(f.message)),
    );
  }

  Future<void> logout() async {
    if (!isClosed) emit(AuthLoading());
    final result = await _logoutUseCase();
    if (isClosed) return;
    result.when(
      success: (_) {
        _authRefreshNotifier.notifyAuthChanged();
        _analytics.setUserId(null);
        emit(AuthInitial());
      },
      onFailure: (f) => emit(AuthError(f.message)),
    );
  }

  Future<void> loginWithGoogle() async {
    if (!isClosed) emit(AuthLoading());
    try {
      final idToken = await _socialSignInService.signInWithGoogle();
      if (isClosed) return;
      final result = await _loginWithGoogleUseCase(idToken);
      if (isClosed) return;
      result.when(
        success: (user) {
          _authRefreshNotifier.notifyAuthChanged();
          _analytics.logEvent('login_google');
          _analytics.setUserId(user.id);
          emit(AuthLoaded(user));
        },
        onFailure: (f) => emit(AuthError(f.message)),
      );
    } catch (e) {
      if (isClosed) return;
      final msg = e.toString();
      if (msg.contains('cancelled') || msg.contains('CANCELED')) {
        emit(AuthInitial());
      } else {
        emit(AuthError(msg));
      }
    }
  }

  Future<void> loginWithApple() async {
    if (!isClosed) emit(AuthLoading());
    try {
      final idToken = await _socialSignInService.signInWithApple();
      if (isClosed) return;
      final result = await _loginWithAppleUseCase(idToken);
      if (isClosed) return;
      result.when(
        success: (user) {
          _authRefreshNotifier.notifyAuthChanged();
          _analytics.logEvent('login_apple');
          _analytics.setUserId(user.id);
          emit(AuthLoaded(user));
        },
        onFailure: (f) => emit(AuthError(f.message)),
      );
    } catch (e) {
      if (isClosed) return;
      final msg = e.toString();
      if (msg.contains('cancelled') || msg.contains('CANCELED') ||
          msg.contains('canceled') || msg.contains('AuthorizationErrorCode.canceled')) {
        emit(AuthInitial());
      } else {
        emit(AuthError(msg));
      }
    }
  }

  Future<void> checkCachedUser() async {
    if (!isClosed) emit(AuthLoading());
    final result = await _getCachedUserUseCase();
    if (isClosed) return;
    result.when(
      success: (user) {
        if (user != null) {
          emit(AuthLoaded(user));
        } else {
          emit(AuthInitial());
        }
      },
      onFailure: (f) => emit(AuthError(f.message)),
    );
  }
}
