import 'package:flutter/material.dart';
import 'package:hungry/features/auth/presentation/views/login_view.dart';
// import 'package:hungry/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hungry',
      // home: SplashView(),
      home: LoginView(),
    );
  }
}

