import '../../domain/entities/cart_item_entity.dart';

class CartItemModel extends CartItemEntity {
  const CartItemModel({
    required super.id,
    required super.productId,
    required super.name,
    required super.price,
    super.quantity = 1,
    super.priceDisplay,
    super.image,
    super.spicy = 0,
    super.toppingNames = const [],
    super.sideOptionNames = const [],
    super.toppingIds = const [],
    super.sideOptionIds = const [],
  });

  static String? _str(dynamic v) {
    if (v == null) return null;
    return v is String ? v : v.toString();
  }

  static double _num(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }

  static int _int(dynamic v) {
    if (v == null) return 1;
    if (v is int) return v;
    if (v is double) return v.toInt();
    return int.tryParse(v.toString()) ?? 1;
  }

  /// Prefer line/item id (for remove) then fallback to product id.
  static String? _parseLineId(Map<String, dynamic> json) {
    for (final key in ['id', 'item_id', 'cart_item_id', 'line_id']) {
      final v = json[key];
      if (v != null) return v is String ? v : v.toString();
    }
    return null;
  }

  /// Parse list of maps with 'name' (e.g. toppings, side_options).
  static List<String> _parseNameList(dynamic raw) {
    if (raw == null || raw is! List) return const [];
    final names = <String>[];
    for (final e in raw) {
      if (e is Map) {
        final name = _str(e['name'] ?? e['title']);
        if (name != null && name.isNotEmpty) names.add(name);
      }
    }
    return names;
  }

  factory CartItemModel.fromJson(Map<String, dynamic>? json) {
    if (json == null || json.isEmpty) {
      return const CartItemModel(
        id: '',
        productId: '',
        name: '',
        price: 0.0,
        quantity: 1,
      );
    }
    final product = json['product'] is Map
        ? Map<String, dynamic>.from(json['product'] as Map)
        : null;
    final lineId = _parseLineId(json);
    final productId = _str(
          json['product_id'] ??
              json['productId'] ??
              product?['id'] ??
              product?['product_id']) ??
        '';
    final id = (lineId != null && lineId.isNotEmpty)
        ? lineId
        : (productId.isNotEmpty ? productId : '');
    final name = _str(
          json['name'] ??
              json['product_name'] ??
              json['title'] ??
              product?['name'] ??
              product?['title']) ??
        '';
    final price = _num(
        json['price'] ?? json['amount'] ?? product?['price'] ?? product?['amount']);
    final quantity = _int(json['quantity']).clamp(1, 999);
    // Prefer API price string so displayed value matches backend (e.g. "140.00")
    final priceDisplay = _str(
        json['price_display'] ?? json['priceDisplay'] ?? json['price'] ?? product?['price_display'] ?? product?['price']);
    final image = _str(json['image'] ?? json['image_url'] ?? product?['image']);
    final spicy = _num(json['spicy']);
    final toppingNames = _parseNameList(json['toppings'] ?? json['topping_names']);
    final sideOptionNames = _parseNameList(
        json['side_options'] ?? json['side_options_names'] ?? json['sides']);
    return CartItemModel(
      id: id,
      productId: productId,
      name: name,
      price: price,
      quantity: quantity,
      priceDisplay: priceDisplay,
      image: image?.isEmpty == true ? null : image,
      spicy: spicy.clamp(0.0, 1.0),
      toppingNames: toppingNames,
      sideOptionNames: sideOptionNames,
      toppingIds: _parseIdList(json['toppings'] ?? json['topping_ids']),
      sideOptionIds: _parseIdList(json['side_options'] ?? json['side_option_ids']),
    );
  }

  static List<int> _parseIdList(dynamic raw) {
    if (raw == null || raw is! List) return const [];
    final ids = <int>[];
    for (final e in raw) {
      if (e is int) {
        ids.add(e);
      } else if (e is num) {
        ids.add(e.toInt());
      } else if (e is Map) {
        final id = e['id'];
        if (id is int) ids.add(id);
        else if (id is num) ids.add(id.toInt());
        else if (id != null) {
          final n = int.tryParse(id.toString());
          if (n != null) ids.add(n);
        }
      } else {
        final n = int.tryParse(e.toString());
        if (n != null) ids.add(n);
      }
    }
    return ids;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_id': productId,
        'name': name,
        'price': price,
        'quantity': quantity,
        'image': image,
        'spicy': spicy,
        'toppingNames': toppingNames,
        'sideOptionNames': sideOptionNames,
      };
}
