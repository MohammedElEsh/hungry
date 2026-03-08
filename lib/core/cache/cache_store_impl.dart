import 'package:hive_flutter/hive_flutter.dart';

import 'cache_store.dart';

const _boxName = 'app_cache';
const _keyCategories = 'categories';
const _keyCategoriesTs = 'categories_ts';
const _keyProducts = 'products';
const _keyProductsTs = 'products_ts';
const _keyOrders = 'orders';
const _keyOrdersTs = 'orders_ts';

class CacheStoreImpl implements CacheStore {
  Box<dynamic>? _box;

  Future<Box<dynamic>> _getBox() async {
    _box ??= await Hive.openBox(_boxName);
    return _box!;
  }

  @override
  Future<List<Map<String, dynamic>>?> getCachedCategories() async {
    final box = await _getBox();
    final ts = box.get(_keyCategoriesTs) as int?;
    if (CacheStore.isExpired(ts)) return null;
    final list = box.get(_keyCategories);
    if (list is! List) return null;
    return list
        .map((e) => e is Map ? Map<String, dynamic>.from(e) : null)
        .whereType<Map<String, dynamic>>()
        .toList();
  }

  @override
  Future<void> setCachedCategories(List<Map<String, dynamic>> data) async {
    final box = await _getBox();
    await box.put(_keyCategories, data);
    await box.put(_keyCategoriesTs, DateTime.now().millisecondsSinceEpoch);
  }

  @override
  Future<List<Map<String, dynamic>>?> getCachedProducts() async {
    final box = await _getBox();
    final ts = box.get(_keyProductsTs) as int?;
    if (CacheStore.isExpired(ts)) return null;
    final list = box.get(_keyProducts);
    if (list is! List) return null;
    return list
        .map((e) => e is Map ? Map<String, dynamic>.from(e) : null)
        .whereType<Map<String, dynamic>>()
        .toList();
  }

  @override
  Future<void> setCachedProducts(List<Map<String, dynamic>> data) async {
    final box = await _getBox();
    await box.put(_keyProducts, data);
    await box.put(_keyProductsTs, DateTime.now().millisecondsSinceEpoch);
  }

  @override
  Future<List<Map<String, dynamic>>?> getCachedOrders() async {
    final box = await _getBox();
    final ts = box.get(_keyOrdersTs) as int?;
    if (CacheStore.isExpired(ts)) return null;
    final list = box.get(_keyOrders);
    if (list is! List) return null;
    return list
        .map((e) => e is Map ? Map<String, dynamic>.from(e) : null)
        .whereType<Map<String, dynamic>>()
        .toList();
  }

  @override
  Future<void> setCachedOrders(List<Map<String, dynamic>> data) async {
    final box = await _getBox();
    await box.put(_keyOrders, data);
    await box.put(_keyOrdersTs, DateTime.now().millisecondsSinceEpoch);
  }
}
