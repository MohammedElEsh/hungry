import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'package:hungry/core/components/custom_button.dart';

class EmptyCartWidget extends StatelessWidget {
  final VoidCallback? onContinueShopping;

  const EmptyCartWidget({super.key, this.onContinueShopping});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: AppColors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: 24),
            Text(
              'Your cart is empty',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Add items from the menu to get started',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
            if (onContinueShopping != null) ...[
              const SizedBox(height: 24),
              CustomButton(
                text: 'Continue Shopping',
                onPressed: onContinueShopping!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
