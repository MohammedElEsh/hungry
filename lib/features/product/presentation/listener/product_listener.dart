import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/app_router.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../cubit/product_cubit.dart';
import '../actions/product_actions.dart';

/// Handles Product and Cart Bloc state side-effects: banners, navigation.
/// UI for each state is built by [ProductViewFactory].
abstract final class ProductListener {
  static void listenProduct(BuildContext context, ProductState state) {
    if (state is! ProductLoaded) return;
    if (state.addToCartSuccess == true && context.mounted) {
      showSuccessBanner(context, 'Added to cart');
      context.read<CartCubit>().loadCart();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        context.go(AppRouter.kHomeView);
      });
    }
    if (state.addToCartError != null && context.mounted) {
      showErrorBanner(context, state.addToCartError!);
      ProductActions.clearAddToCartResult(context);
    }
  }

  static void listenCart(BuildContext context, CartState state) {
    if (state is CartError && context.mounted) {
      showErrorBanner(context, state.message);
    }
  }
}
