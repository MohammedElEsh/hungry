import 'package:flutter/material.dart';

import '../../../../core/utils/styles.dart';

/// Shown when no product id or initial state.
class ProductInitialView extends StatelessWidget {
  final String? productId;

  const ProductInitialView({super.key, this.productId});

  @override
  Widget build(BuildContext context) {
    final message = productId == null || productId!.isEmpty
        ? 'No product selected'
        : 'Loading...';
    return Scaffold(
      body: Center(
        child: Text(message, style: AppTextStyles.bodyMedium),
      ),
    );
  }
}
