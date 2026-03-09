import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/di/injection.dart';
import 'package:hungry/core/analytics/analytics_service.dart';
import 'package:hungry/core/router/analytics_route_observer.dart';
import 'package:hungry/core/router/auth_refresh_notifier.dart';
import 'package:hungry/features/auth/domain/repositories/auth_repository.dart';
import 'package:hungry/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hungry/features/auth/presentation/screens/login_screen.dart';
import 'package:hungry/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:hungry/features/cart/presentation/screens/cart_screen.dart';
import 'package:hungry/splash/presentation/views/splash_view.dart';
import 'package:hungry/core/components/custom_bottom_nav_bar.dart';
import 'package:hungry/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:hungry/features/auth/presentation/screens/signup_screen.dart';
import 'package:hungry/features/checkout/presentation/screens/checkout_screen.dart';
import 'package:hungry/features/home/presentation/cubit/home_cubit.dart';
import 'package:hungry/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:hungry/features/product/presentation/cubit/product_cubit.dart';
import 'package:hungry/features/product/presentation/screens/product_screen.dart';
import 'package:hungry/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:hungry/features/profile/presentation/screens/change_password_screen.dart';
import 'package:hungry/features/profile/presentation/screens/profile_screen.dart';
import 'package:hungry/onboarding/presentation/screens/onboarding_screen.dart';

/// App routing and deep link conventions:
/// - Product: [kProductView]?id=123 or extra: productId (int/String).
/// - Custom scheme (e.g. hungry://product/123) can be mapped to the above in platform config.
abstract class AppRouter {
  static String? _productIdFromExtra(dynamic extra) {
    if (extra == null) return null;
    if (extra is int) return extra.toString();
    if (extra is String && extra.isNotEmpty) return extra;
    if (extra is num) return extra.toInt().toString();
    final s = extra.toString().trim();
    return s.isNotEmpty ? s : null;
  }

  static const kSplashView = '/';
  static const kLoginView = '/loginView';
  static const kSignupView = '/signupView';
  static const kHomeView = '/homeView';
  static const kProductView = '/productView';
  static const kCheckoutView = '/checkoutView';
  static const kCartView = '/cartView';
  static const kProfileView = '/profileView';
  static const kOnboardingView = '/onboardingView';
  static const kForgetPasswordView = '/forgetPasswordView';
  static const kChangePasswordView = '/changePasswordView';

  static const _publicPaths = {
    kSplashView,
    kHomeView,
    kLoginView,
    kSignupView,
    kOnboardingView,
    kForgetPasswordView,
  };

  static String? _redirect(BuildContext context, GoRouterState state) {
    final path = state.uri.path;
    final auth = sl<AuthRepository>();
    final isLoggedInOrGuest = auth.isLoggedIn || auth.isGuest;

    if (_publicPaths.contains(path)) {
      // Logged-in users: redirect away from login/signup. Guests: allow signup (they want to create account).
      if ((path == kLoginView || path == kSignupView) && auth.isLoggedIn) {
        return kHomeView;
      }
      return null;
    }

    if (!isLoggedInOrGuest) {
      return kLoginView;
    }
    if (path == kChangePasswordView && !auth.isLoggedIn) {
      return kLoginView;
    }
    return null;
  }

  static final GoRouter router = GoRouter(
    initialLocation: kSplashView,
    refreshListenable: sl<AuthRefreshNotifier>(),
    redirect: _redirect,
    observers: [AnalyticsRouteObserver(sl<AnalyticsService>())],
    routes: [
      GoRoute(
        path: kSplashView,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kOnboardingView,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: kForgetPasswordView,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<AuthCubit>(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: kSignupView,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<AuthCubit>(),
          child: const SignupScreen(),
        ),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider<HomeCubit>.value(value: sl<HomeCubit>()),
            BlocProvider<CartCubit>.value(value: sl<CartCubit>()),
            BlocProvider<OrdersCubit>.value(value: sl<OrdersCubit>()),
            BlocProvider<ProfileCubit>.value(value: sl<ProfileCubit>()),
          ],
          child: const _HomeLoadTrigger(),
        ),
      ),
      GoRoute(
        path: kProductView,
        builder: (context, state) {
          final id = _productIdFromExtra(state.extra) ??
              state.uri.queryParameters['id'] ??
              state.uri.queryParameters['productId'];
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: sl<CartCubit>()),
              BlocProvider(create: (_) => sl<ProductCubit>()),
            ],
            child: ProductScreen(productId: id),
          );
        },
      ),
      GoRoute(
        path: kCheckoutView,
        builder: (context, state) => BlocProvider.value(
          value: sl<CartCubit>(),
          child: const CheckoutScreen(),
        ),
      ),
      GoRoute(
        path: kCartView,
        builder: (context, state) => BlocProvider.value(
          value: sl<CartCubit>()..loadCart(),
          child: const CartScreen(),
        ),
      ),
      GoRoute(
        path: kChangePasswordView,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: kProfileView,
        builder: (context, state) => BlocProvider.value(
          value: sl<ProfileCubit>(),
          child: const ProfileScreen(),
        ),
      ),
    ],
  );
}

/// Ensures products and cart load every time the Home route is built (e.g. after context.go(Home)).
class _HomeLoadTrigger extends StatefulWidget {
  const _HomeLoadTrigger();

  @override
  State<_HomeLoadTrigger> createState() => _HomeLoadTriggerState();
}

class _HomeLoadTriggerState extends State<_HomeLoadTrigger> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<HomeCubit>().refresh();
      context.read<CartCubit>().loadCart();
    });
  }

  @override
  Widget build(BuildContext context) => const CustomBottomNavBar();
}
