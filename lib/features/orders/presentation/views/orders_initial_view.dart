import 'package:flutter/material.dart';

import 'orders_loading_view.dart';

/// Shown for [OrdersInitial] or unknown state.
class OrdersInitialView extends StatelessWidget {
  const OrdersInitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return const OrdersLoadingView();
  }
}
