import 'package:flutter/material.dart';

import '../../../../core/widgets/empty_cart_widget.dart';

/// Empty cart state. Callback from screen.
class CartEmptyView extends StatelessWidget {
  final VoidCallback onContinueShopping;

  const CartEmptyView({super.key, required this.onContinueShopping});

  @override
  Widget build(BuildContext context) {
    return EmptyCartWidget(
      onContinueShopping: onContinueShopping,
    );
  }
}
