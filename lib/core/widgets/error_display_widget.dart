import 'package:flutter/material.dart';

import '../constants/app_strings.dart';
import 'package:hungry/core/components/custom_button.dart';

/// Reusable error display widget with retry.
class ErrorDisplayWidget extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;

  const ErrorDisplayWidget({
    super.key,
    this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              message ?? AppStrings.error,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              CustomButton(
                text: AppStrings.retry,
                onPressed: onRetry,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
