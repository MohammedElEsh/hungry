/// Cache for products, categories, orders. Used when offline.
abstract class CacheStore {
  Future<List<Map<String, dynamic>>?> getCachedCategories();
  Future<void> setCachedCategories(List<Map<String, dynamic>> data);

  Future<List<Map<String, dynamic>>?> getCachedProducts();
  Future<void> setCachedProducts(List<Map<String, dynamic>> data);

  Future<List<Map<String, dynamic>>?> getCachedOrders();
  Future<void> setCachedOrders(List<Map<String, dynamic>> data);

  static const _maxAgeHours = 24;
  static bool isExpired(int? ts) {
    if (ts == null) return true;
    final age = DateTime.now().millisecondsSinceEpoch - ts;
    return age > _maxAgeHours * 60 * 60 * 1000;
  }
}
