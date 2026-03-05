import 'package:hungry/core/domain/result.dart';
import 'package:hungry/features/cart/domain/entities/cart_item_entity.dart';

import '../entities/cart_data.dart';

abstract class CartRepository {
  Future<Result<CartData>> getCartItems();
  Future<Result<void>> addToCart(CartItemEntity item);
  Future<Result<void>> removeFromCart(String itemId);
  Future<Result<void>> clearCart();
}
