import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/injection.dart';
import 'core/hive/hive_manager.dart';
import 'core/network/token_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_router.dart';
import 'core/utils/pref_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveManager.init();
  await init();

  final token = await PrefHelper.getToken();
  if (token != null && token.isNotEmpty) {
    sl<TokenProvider>().setToken(token);
  }

  runApp(const MyApp());
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
        );
      },
    );
  }
}
