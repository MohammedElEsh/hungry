/// Service for showing local notifications (order placed, order status).
abstract class AppNotificationService {
  Future<void> init();
  Future<void> requestPermissions();
  Future<void> showOrderPlaced();
  Future<void> showOrderStatusChanged(String orderId, String status);
}
