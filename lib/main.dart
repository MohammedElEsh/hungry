import 'dart:async';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/di/injection.dart';
import 'core/hive/hive_manager.dart';
import 'core/logger/app_logger.dart';
import 'core/logger/app_logger_interface.dart';
import 'core/network/token_provider.dart';
import 'core/storage/app_preferences.dart';
import 'core/storage/token_storage.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/locale_notifier.dart';
import 'core/theme/theme_notifier.dart';
import 'core/notifications/notification_service.dart' as notifications;
import 'core/utils/app_router.dart';

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

          final appPrefs = sl<AppPreferences>();
          await _migrateFromPrefHelper(appPrefs);
          var savedLocale = await appPrefs.getLocale();
          final startLocale =
              savedLocale == 'ar' ? const Locale('ar') : const Locale('en');

          await sl<ThemeNotifier>().init();
          await sl<LocaleNotifier>().init();
          await sl<notifications.AppNotificationService>().init();

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

Future<void> _migrateFromPrefHelper(AppPreferences appPrefs) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    if (await appPrefs.getLocale() == null) {
      final locale = prefs.getString('locale');
      if (locale != null) await appPrefs.setLocale(locale);
    }
    final guestMode = prefs.getBool('guest_mode');
    if (guestMode == true) await appPrefs.setGuestMode(true);
  } catch (_) {}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = sl<ThemeNotifier>();
    final localeNotifier = sl<LocaleNotifier>();
    final listenable = Listenable.merge([themeNotifier, localeNotifier]);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return ListenableBuilder(
          listenable: listenable,
          builder: (context, _) {
            final isRtl = localeNotifier.locale.languageCode == 'ar';
            return MaterialApp.router(
              key: ValueKey(
                '${themeNotifier.themeMode.index}_${localeNotifier.locale.languageCode}',
              ),
              debugShowCheckedModeBanner: false,
              title: 'app_name'.tr(),
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeNotifier.themeMode,
              routerConfig: AppRouter.router,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: localeNotifier.locale,
              builder: (context, child) => Directionality(
                textDirection: isRtl ? ui.TextDirection.rtl : ui.TextDirection.ltr,
                child: child ?? const SizedBox.shrink(),
              ),
            );
          },
        );
      },
    );
  }
}
