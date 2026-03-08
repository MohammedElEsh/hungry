import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_service.dart';

class NotificationServiceImpl implements AppNotificationService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'hungry_orders',
    'Orders',
    description: 'Order placed and status updates',
    importance: Importance.high,
    playSound: true,
  );

  @override
  Future<void> init() async {
    if (_initialized) return;
    const android = AndroidInitializationSettings('@mipmap/launcher_icon');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
    );
    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
    _initialized = true;
  }

  @override
  Future<void> requestPermissions() async {
    await _plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  @override
  Future<void> showOrderPlaced() async {
    await _plugin.show(
      1,
      'Order placed',
      'Your order has been placed successfully',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'hungry_orders',
          'Orders',
          channelDescription: 'Order placed and status updates',
          importance: Importance.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  @override
  Future<void> showOrderStatusChanged(String orderId, String status) async {
    await _plugin.show(
      orderId.hashCode & 0x7FFFFFFF,
      'Order #$orderId',
      'Status: $status',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'hungry_orders',
          'Orders',
          channelDescription: 'Order placed and status updates',
          importance: Importance.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}
