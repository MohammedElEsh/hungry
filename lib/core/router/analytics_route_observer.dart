import 'package:flutter/material.dart';

import '../analytics/analytics_service.dart';

/// Logs screen views to analytics when route changes.
class AnalyticsRouteObserver extends NavigatorObserver {
  AnalyticsRouteObserver(this._analytics);

  final AnalyticsService _analytics;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final name = route.settings.name ?? route.toString();
    _analytics.logEvent('screen_view', {'route': name});
  }
}
