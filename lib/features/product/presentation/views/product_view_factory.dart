import 'package:flutter/material.dart';

import '../cubit/product_cubit.dart';
import 'product_error_view.dart';
import 'product_initial_view.dart';
import 'product_loaded_view.dart';
import 'product_loading_view.dart';

/// Builds the appropriate view for each [ProductState]. No side-effects; use [ProductListener].
abstract final class ProductViewFactory {
  static Widget build(
    BuildContext context,
    ProductState state, {
    required String? productId,
  }) {
    if (state is ProductLoading) {
      return const ProductLoadingView();
    }
    if (state is ProductError) {
      return ProductErrorView(
        message: state.message,
        productId: productId ?? '',
      );
    }
    if (state is ProductLoaded) {
      return ProductLoadedView(state: state);
    }
    return ProductInitialView(productId: productId);
  }
}
