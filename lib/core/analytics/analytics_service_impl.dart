import 'package:flutter/foundation.dart';

import 'analytics_service.dart';

/// Default implementation: logs in debug; replace with real provider (Mixpanel, PostHog, etc.) in production.
class AnalyticsServiceImpl implements AnalyticsService {
  @override
  void logEvent(String name, [Map<String, dynamic>? params]) {
    if (kDebugMode) {
      // ignore: avoid_print
      print('[Analytics] $name ${params ?? {}}');
    }
  }

  @override
  void setUserId(String? id) {
    if (kDebugMode && id != null) {
      // ignore: avoid_print
      print('[Analytics] setUserId: $id');
    }
  }
}
