import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/di/injection.dart';
import 'core/hive/hive_manager.dart';
import 'core/logger/app_logger.dart';
import 'core/logger/app_logger_interface.dart';
import 'core/network/token_provider.dart';
import 'core/storage/token_storage.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_router.dart';
import 'core/utils/pref_helper.dart';

void main() {
  runZonedGuarded(
    () async {
      SentryWidgetsFlutterBinding.ensureInitialized();

      await SentryFlutter.init(
        (options) {
          options.dsn = const String.fromEnvironment(
            'SENTRY_DSN',
            defaultValue: '',
          );
          options.tracesSampleRate = 0.0;
        },
        appRunner: () async {
          await HiveManager.init();
          await init();

          AppLogger.instance = sl<AppLoggerInterface>();

          FlutterError.onError = (FlutterErrorDetails details) {
            AppLogger.e(
              details.exceptionAsString(),
              details.exception,
              details.stack,
            );
            Sentry.captureException(
              details.exception,
              stackTrace: details.stack,
            );
            FlutterError.presentError(details);
          };

          final token = await sl<TokenStorage>().getToken();
          if (token != null && token.isNotEmpty) {
            sl<TokenProvider>().setToken(token);
          }

          final savedLocale = await PrefHelper.getLocale();
          final startLocale = savedLocale != null && savedLocale == 'ar'
              ? const Locale('ar')
              : const Locale('en');

          runApp(
            EasyLocalization(
              supportedLocales: const [Locale('en'), Locale('ar')],
              path: 'assets/translations',
              fallbackLocale: const Locale('en'),
              startLocale: startLocale,
              child: const MyApp(),
            ),
          );
        },
      );
    },
    (Object error, StackTrace stack) {
      AppLogger.e('Uncaught async error', error, stack);
      Sentry.captureException(error, stackTrace: stack);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Hungry',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.light,
          routerConfig: AppRouter.router,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}
