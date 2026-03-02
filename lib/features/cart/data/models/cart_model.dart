/// Display model for cart response (GET /cart)
class CartModel {
  final int? id;
  final String totalPrice;
  final List<CartDisplayItem> items;

  CartModel({this.id, required this.totalPrice, required this.items});

  factory CartModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return CartModel(totalPrice: '0', items: []);
    final itemsList = json['items'];
    if (itemsList == null || itemsList is! List) {
      return CartModel(
        totalPrice: (json['total_price'] ?? '0').toString(),
        items: [],
      );
    }
    return CartModel(
      id: json['id'] as int?,
      totalPrice: (json['total_price'] ?? '0').toString(),
      items: itemsList
          .map<CartDisplayItem>(
            (item) => CartDisplayItem.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

/// Cart item from API response
class CartDisplayItem {
  final int itemId;
  final int productId;
  final String name;
  final String? image;
  final int quantity;
  final String price;
  final double spicy;
  final List<ToppingDisplay> toppings;
  final List<SideOptionDisplay> sideOptions;

  CartDisplayItem({
    required this.itemId,
    required this.productId,
    required this.name,
    this.image,
    required this.quantity,
    required this.price,
    required this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

  factory CartDisplayItem.fromJson(Map<String, dynamic> json) {
    return CartDisplayItem(
      itemId: json['item_id'] as int,
      productId: json['product_id'] as int,
      name: (json['name'] ?? '') as String,
      image: json['image'] as String?,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      price: (json['price'] ?? '0').toString(),
      spicy: (json['spicy'] is num)
          ? (json['spicy'] as num).toDouble()
          : double.tryParse((json['spicy'] ?? '0').toString()) ?? 0.0,
      toppings:
          (json['toppings'] as List?)
              ?.map((e) => ToppingDisplay.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      sideOptions:
          (json['side_options'] as List?)
              ?.map(
                (e) => SideOptionDisplay.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }
}

class ToppingDisplay {
  final int id;
  final String name;
  final String? image;

  ToppingDisplay({required this.id, required this.name, this.image});

  factory ToppingDisplay.fromJson(Map<String, dynamic> json) {
    return ToppingDisplay(
      id: json['id'] as int,
      name: (json['name'] ?? '') as String,
      image: json['image'] as String?,
    );
  }
}

class SideOptionDisplay {
  final int id;
  final String name;
  final String? image;

  SideOptionDisplay({required this.id, required this.name, this.image});

  factory SideOptionDisplay.fromJson(Map<String, dynamic> json) {
    return SideOptionDisplay(
      id: json['id'] as int,
      name: (json['name'] ?? '') as String,
      image: json['image'] as String?,
    );
  }
}

/// Request model for add to cart (POST /cart/add)
class CartItem {
  final int productId;
  final int quantity;
  final double spicy;
  final List<int> toppings;
  final List<int> sideOptions;

  CartItem({
    required this.productId,
    required this.quantity,
    required this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

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
