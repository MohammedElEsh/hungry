import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../cubit/orders_cubit.dart';
import '../widgets/empty_orders_view.dart';
import '../widgets/guest_orders_view.dart';
import 'orders_error_view.dart';
import 'orders_initial_view.dart';
import 'orders_loaded_view.dart';
import 'orders_loading_view.dart';

/// Builds the appropriate view for each [OrdersState]. No side-effects; use [OrdersListener].
abstract final class OrdersViewFactory {
  static Widget build(
    BuildContext context,
    OrdersState state, {
    required VoidCallback onHomeTap,
  }) {
    if (state is OrdersGuest) {
      return const GuestOrdersView();
    }
    if (state is OrdersLoading) {
      return const OrdersLoadingView();
    }
    if (state is OrdersError) {
      return OrdersErrorView(message: state.message);
    }
    if (state is OrdersLoaded) {
      if (state.orders.isEmpty) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: EmptyOrdersView(onHomeTap: onHomeTap),
        );
      }
      return OrdersLoadedView(orders: state.orders);
    }
    return const OrdersInitialView();
  }
}
