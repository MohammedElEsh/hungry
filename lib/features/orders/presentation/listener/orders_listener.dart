import 'package:flutter/material.dart';

import '../cubit/orders_cubit.dart';

/// Handles Orders Bloc state side-effects only: snackbars, navigation, banners.
/// UI for each state is built by [OrdersViewFactory].
abstract final class OrdersListener {
  static void listen(BuildContext context, OrdersState state) {
    if (state is OrdersError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }


}
