import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import '../auth/social_sign_in_service.dart';
import '../cache/cache_store.dart';
import '../cache/cache_store_impl.dart';
import '../notifications/notification_service.dart' as notifications;
import '../notifications/notification_service_impl.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../network/token_provider.dart';
import '../analytics/analytics_service.dart';
import '../analytics/analytics_service_impl.dart';
import '../logger/app_logger_interface.dart';
import '../logger/app_logger_impl.dart';
import '../interceptors/auth_interceptor.dart';
import '../storage/app_preferences.dart';
import '../storage/app_preferences_impl.dart';
import '../storage/secure_storage.dart';
import '../storage/secure_storage_impl.dart';
import '../theme/theme_notifier.dart';
import '../router/auth_refresh_notifier.dart';
import '../storage/token_storage.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_cached_user_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/login_with_apple_usecase.dart';
import '../../features/auth/domain/usecases/login_with_google_usecase.dart';
import '../../features/auth/domain/usecases/request_password_reset_otp_usecase.dart';
import '../../features/auth/domain/usecases/reset_password_with_otp_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/cart/data/datasources/cart_remote_datasource.dart';
import '../../features/cart/data/repositories/cart_repository_impl.dart';
import '../../features/cart/domain/repositories/cart_repository.dart';
import '../../features/cart/domain/usecases/add_to_cart_usecase.dart';
import '../../features/cart/domain/usecases/clear_cart_usecase.dart';
import '../../features/cart/domain/usecases/get_cart_items_usecase.dart';
import '../../features/cart/domain/usecases/remove_from_cart_usecase.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';
import '../../features/home/data/datasources/category_remote_datasource.dart';
import '../../features/home/data/datasources/favorite_remote_datasource.dart';
import '../../features/home/data/datasources/product_remote_datasource.dart';
import '../../features/home/data/repositories/category_repository_impl.dart';
import '../../features/home/data/repositories/favorite_repository_impl.dart';
import '../../features/home/data/repositories/product_repository_impl.dart';
import '../../features/home/domain/repositories/category_repository.dart';
import '../../features/home/domain/repositories/favorite_repository.dart';
import '../../features/home/domain/repositories/product_repository.dart';
import '../../features/home/domain/usecases/get_categories_usecase.dart';
import '../../features/home/domain/usecases/get_favorites_usecase.dart';
import '../../features/home/domain/usecases/get_products_usecase.dart';
import '../../features/home/domain/usecases/toggle_favorite_usecase.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/product/data/datasources/product_remote_datasource.dart';
import '../../features/product/data/repositories/product_detail_repository_impl.dart';
import '../../features/product/domain/repositories/product_detail_repository.dart';
import '../../features/product/domain/usecases/get_product_detail_usecase.dart';
import '../../features/product/presentation/cubit/product_cubit.dart';
import '../../features/orders/data/datasources/order_remote_datasource.dart';
import '../../features/orders/data/repositories/order_repository_impl.dart';
import '../../features/orders/domain/repositories/order_repository.dart';
import '../../features/orders/domain/usecases/create_order_usecase.dart';
import '../../features/orders/domain/usecases/get_orders_usecase.dart';
import '../../features/orders/presentation/cubit/orders_cubit.dart';
import '../../features/auth/data/repositories/auth_repo.dart';
import '../../features/auth/domain/auth_state_source.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/change_password_usecase.dart';
import '../../features/profile/domain/usecases/delete_account_usecase.dart';
import '../../features/profile/domain/usecases/get_profile_usecase.dart';
import '../../features/profile/domain/usecases/profile_logout_usecase.dart';
import '../../features/profile/domain/usecases/update_profile_usecase.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<AppLoggerInterface>(() => AppLoggerImpl());
  sl.registerLazySingleton<AnalyticsService>(() => AnalyticsServiceImpl());
  sl.registerLazySingleton<AuthRefreshNotifier>(() => AuthRefreshNotifier());
  sl.registerLazySingleton<TokenProvider>(() => TokenProviderImpl());
  sl.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(sl<TokenProvider>()),
  );
  sl.registerLazySingleton<DioClient>(
    () => DioClient(authInterceptor: sl<AuthInterceptor>()),
  );
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );

  sl.registerLazySingleton<SecureStorage>(() => SecureStorageImpl());
  sl.registerLazySingleton<TokenStorage>(
    () => TokenStorageImpl(sl<SecureStorage>()),
  );
  sl.registerLazySingleton<AppPreferences>(() => AppPreferencesImpl());
  sl.registerLazySingleton<ThemeNotifier>(
    () => ThemeNotifier(sl<AppPreferences>()),
  );
  sl.registerLazySingleton<CacheStore>(() => CacheStoreImpl());
  sl.registerLazySingleton<notifications.AppNotificationService>(
    () => NotificationServiceImpl(),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepo(
      sl<TokenStorage>(),
      sl<TokenProvider>(),
      sl<AuthRefreshNotifier>(),
      sl<AppPreferences>(),
    ),
  );
  sl.registerLazySingleton<AuthStateSource>(() => sl<AuthRepo>());
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sl<AuthRemoteDataSource>(),
      sl<NetworkInfo>(),
      sl<TokenProvider>(),
      sl<TokenStorage>(),
      sl<AuthRepo>(),
      sl<AppPreferences>(),
    ),
  );
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => RegisterUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => LogoutUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => GetCachedUserUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<SocialSignInService>(() => SocialSignInServiceImpl());
  sl.registerLazySingleton(() => LoginWithGoogleUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => LoginWithAppleUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => RequestPasswordResetOtpUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => ResetPasswordWithOtpUseCase(sl<AuthRepository>()));

  sl.registerFactory(() => AuthCubit(
        sl<LoginUseCase>(),
        sl<LogoutUseCase>(),
        sl<GetCachedUserUseCase>(),
        sl<RegisterUseCase>(),
        sl<LoginWithGoogleUseCase>(),
        sl<LoginWithAppleUseCase>(),
        sl<SocialSignInService>(),
        sl<AuthRefreshNotifier>(),
        sl<AnalyticsService>(),
      ));

  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(sl<CartRemoteDataSource>(), sl<NetworkInfo>()),
  );
  sl.registerLazySingleton(() => GetCartItemsUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => AddToCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => RemoveFromCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => ClearCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => CartCubit(
        sl<GetCartItemsUseCase>(),
        sl<AddToCartUseCase>(),
        sl<RemoveFromCartUseCase>(),
        sl<ClearCartUseCase>(),
      ));

  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl<ProductRemoteDataSource>(), sl<NetworkInfo>(), sl<CacheStore>()),
  );
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(sl<CategoryRemoteDataSource>(), sl<NetworkInfo>(), sl<CacheStore>()),
  );
  sl.registerLazySingleton<FavoriteRemoteDataSource>(
    () => FavoriteRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<FavoriteRepository>(
    () => FavoriteRepositoryImpl(sl<FavoriteRemoteDataSource>()),
  );
  sl.registerLazySingleton(() => GetProductsUseCase(sl<ProductRepository>()));
  sl.registerLazySingleton(
      () => GetCategoriesUseCase(sl<CategoryRepository>()));
  sl.registerLazySingleton(
      () => GetFavoritesUseCase(sl<FavoriteRepository>()));
  sl.registerLazySingleton(
      () => ToggleFavoriteUseCase(sl<FavoriteRepository>()));
  sl.registerLazySingleton(() => HomeCubit(
        sl<GetProductsUseCase>(),
        sl<GetCategoriesUseCase>(),
        sl<GetFavoritesUseCase>(),
        sl<ToggleFavoriteUseCase>(),
        sl<GetCachedUserUseCase>(),
        sl<GetProfileUseCase>(),
      ));

  sl.registerLazySingleton<ProductDetailRemoteDataSource>(
    () => ProductDetailRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<ProductDetailRepository>(
    () => ProductDetailRepositoryImpl(sl<ProductDetailRemoteDataSource>()),
  );
  sl.registerLazySingleton(
      () => GetProductDetailUseCase(sl<ProductDetailRepository>()));
  sl.registerFactory(() => ProductCubit(
        sl<GetProductDetailUseCase>(),
        sl<AddToCartUseCase>(),
      ));

  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(sl<OrderRemoteDataSource>(), sl<NetworkInfo>(), sl<CacheStore>()),
  );
  sl.registerLazySingleton(() => GetOrdersUseCase(sl<OrderRepository>()));
  sl.registerLazySingleton(
      () => CreateOrderUseCase(sl<OrderRepository>()));
  sl.registerLazySingleton(() => OrdersCubit(
        sl<GetOrdersUseCase>(),
        sl<GetCachedUserUseCase>(),
      ));

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl<AuthRepo>()),
  );
  sl.registerLazySingleton(() => GetProfileUseCase(sl<ProfileRepository>()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl<ProfileRepository>()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl<ProfileRepository>()));
  sl.registerLazySingleton(
      () => UpdateProfileUseCase(sl<ProfileRepository>()));
  sl.registerLazySingleton(
      () => ProfileLogoutUseCase(sl<ProfileRepository>()));
  sl.registerLazySingleton(() => ProfileCubit(
        sl<GetProfileUseCase>(),
        sl<UpdateProfileUseCase>(),
        sl<ProfileLogoutUseCase>(),
      ));
}
