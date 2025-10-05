import 'package:go_router/go_router.dart';
import 'package:hungry/features/auth/presentation/views/login_view.dart';
import 'package:hungry/features/splash/splash_view.dart';
import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/home/presentation/views/home_view.dart';

abstract class AppRouter {
  static const kSplashView = '/';
  static const kLoginView = '/loginView';
  static const kSignupView = '/signupView';
  static const kHomeView = '/homeView';

  static final GoRouter router = GoRouter(
    initialLocation: kSplashView,
    routes: [
      GoRoute(
        path: kSplashView,
        builder: (context, state)
        => const SplashView(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state)
        => const LoginView(),
      ),
      GoRoute(
        path: kSignupView,
        builder: (context, state)
        => const SignupView(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state)
        => const HomeView(),
      ),

    ],
  );
}
