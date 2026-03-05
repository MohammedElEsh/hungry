import 'package:equatable/equatable.dart';

/// Cart item entity (matches API: item_id, product_id, name, image, quantity, price, spicy, toppings, side_options).
class CartItemEntity extends Equatable {
  final String id;
  final String productId;
  final String name;
  final double price;
  final int quantity;
  /// Price as shown by API (e.g. "140.00"). When null, use [price] formatted.
  final String? priceDisplay;
  final String? image;
  final double spicy;
  final List<String> toppingNames;
  final List<String> sideOptionNames;
  /// Topping IDs for API (backend expects bigint ids, not names).
  final List<int> toppingIds;
  final List<int> sideOptionIds;

  const CartItemEntity({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    this.quantity = 1,
    this.priceDisplay,
    this.image,
    this.spicy = 0,
    this.toppingNames = const [],
    this.sideOptionNames = const [],
    this.toppingIds = const [],
    this.sideOptionIds = const [],
  });

  /// Unit price string for UI (like API: "140.00").
  String get priceFormatted => priceDisplay ?? price.toStringAsFixed(2);

  @override
  List<Object?> get props => [id, productId, name, price, quantity, priceDisplay, image, spicy, toppingNames, sideOptionNames, toppingIds, sideOptionIds];
}
