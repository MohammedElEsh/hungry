import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/product_cubit.dart';

/// Entry points for product screen actions. Keeps UI declarative; logic in Cubit.
abstract final class ProductActions {
  static void load(BuildContext context, String productId) {
    context.read<ProductCubit>().loadProduct(productId);
  }

  static void setQuantity(BuildContext context, int qty) {
    context.read<ProductCubit>().setQuantity(qty);
  }

  static void setSpicyLevel(BuildContext context, double value) {
    context.read<ProductCubit>().setSpicyLevel(value);
  }

  static void toggleTopping(BuildContext context, int id) {
    context.read<ProductCubit>().toggleTopping(id);
  }

  static void toggleSideOption(BuildContext context, int id) {
    context.read<ProductCubit>().toggleSideOption(id);
  }

  static void addToCart(BuildContext context) {
    context.read<ProductCubit>().addToCart();
  }

  static void clearAddToCartResult(BuildContext context) {
    context.read<ProductCubit>().clearAddToCartResult();
  }
}
