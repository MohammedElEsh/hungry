/// Analytics interface. Implement with Mixpanel, PostHog, Amplitude, etc.
/// Do not send PII in event params; use IDs where needed.
abstract class AnalyticsService {
  void logEvent(String name, [Map<String, dynamic>? params]);
  void setUserId(String? id);
}
