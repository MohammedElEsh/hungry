/// App configuration. Use --dart-define to override at build/run time.
abstract class AppConfig {
  AppConfig._();

  static String get baseUrl => const String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'https://sonic-zdi0.onrender.com/api/',
      );
}
