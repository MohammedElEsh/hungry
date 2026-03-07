import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Design system spacing. Use for padding, gaps, and margins so layout scales on all devices.
/// Only use inside [ScreenUtilInit] (e.g. anywhere in the app after root).
abstract class AppSpacing {
  static double get xs => 4.r;
  static double get sm => 8.r;
  static double get md => 16.r;
  static double get lg => 24.r;
  static double get xl => 32.r;
  static double get xxl => 40.r;
}
