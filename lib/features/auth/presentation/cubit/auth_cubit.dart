import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/analytics/analytics_service.dart';
import '../../../../core/router/auth_refresh_notifier.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_cached_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCachedUserUseCase _getCachedUserUseCase;
  final RegisterUseCase _registerUseCase;
  final AuthRefreshNotifier _authRefreshNotifier;
  final AnalyticsService _analytics;

  AuthCubit(
    this._loginUseCase,
    this._logoutUseCase,
    this._getCachedUserUseCase,
    this._registerUseCase,
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
