import 'package:go_router/go_router.dart';
import 'package:hungry/features/auth/presentation/views/login_view.dart';
import '../../features/splash/splash_view.dart';

abstract class AppRouter {
  static const kSplashView = '/';
  static const kLoginView = '/loginView';
  // static const kHomeView = '/homeView';

  static final GoRouter router = GoRouter(
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
      // GoRoute(
      //   path: kHomeView,
      //   builder: (context, state)
      //   => const HomeView(),
      // ),
    ],
  );
}
