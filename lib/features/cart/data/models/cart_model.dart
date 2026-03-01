class CartModel {
  final List<CartItem> items;

  CartModel({required this.items});

  factory CartModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return CartModel(items: []);
    final itemsList = json['items'];
    if (itemsList == null || itemsList is! List) return CartModel(items: []);
    return CartModel(
      items: itemsList
          .map<CartItem>(
            (item) => CartItem.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class CartItem {
  final int? id; // Backend-assigned ID, used for remove
  final int productId;
  final int quantity;
  final double spicy;
  final List<int> toppings;
  final List<int> sideOptions;

  CartItem({
    this.id,
    required this.productId,
    required this.quantity,
    required this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as int?,
      productId: json['product_id'],
      quantity: json['quantity'],
      spicy: (json['spicy'] as num).toDouble(),
      toppings: List<int>.from(json['toppings'] ?? []),
      sideOptions: List<int>.from(json['side_options'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'spicy': spicy,
      'toppings': toppings,
      'side_options': sideOptions,
    };
  }
}