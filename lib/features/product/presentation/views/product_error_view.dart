import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/styles.dart';
import '../actions/product_actions.dart';

/// Error state view with retry. Retry via [ProductActions.load].
class ProductErrorView extends StatelessWidget {
  final String message;
  final String productId;

  const ProductErrorView({
    super.key,
    required this.message,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium,
              ),
              const Gap(16),
              TextButton(
                onPressed: () => ProductActions.load(context, productId),
                child: Text('retry'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
