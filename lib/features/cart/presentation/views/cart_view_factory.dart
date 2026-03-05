import 'package:flutter/material.dart';

import '../cubit/cart_cubit.dart';
import 'cart_empty_view.dart';
import 'cart_error_view.dart';
import 'cart_loaded_view.dart';
import 'cart_loading_view.dart';

/// Returns the view for each Cart state. No logic.
class CartViewFactory {
  const CartViewFactory._();

  static Widget build(
    BuildContext context,
    CartState state, {
    required VoidCallback onContinueShopping,
    required VoidCallback onCheckout,
  }) {
    if (state is CartLoading) {
      return const CartLoadingView();
    }
    if (state is CartError) {
      return CartErrorView(message: state.message);
    }
    if (state is CartLoaded) {
      if (state.items.isEmpty) {
        return CartEmptyView(onContinueShopping: onContinueShopping);
      }
      return CartLoadedView(
        items: state.items,
        totalPriceFromApi: state.totalPriceFromApi,
        removingItemId: state.removingItemId,
        onCheckout: onCheckout,
      );
    }
    return CartEmptyView(onContinueShopping: onContinueShopping);
  }
}
