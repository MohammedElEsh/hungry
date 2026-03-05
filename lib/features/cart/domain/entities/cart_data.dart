import 'cart_item_entity.dart';

/// Cart payload: items + optional total_price from API (do not sum items when present).
class CartData {
  final List<CartItemEntity> items;
  final String? totalPriceFromApi;

  const CartData({required this.items, this.totalPriceFromApi});
}
