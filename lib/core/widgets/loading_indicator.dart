import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Centered loading indicator.
class LoadingIndicator extends StatelessWidget {
  final Color? color;

  const LoadingIndicator({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? AppColors.secondary,
      ),
    );
  }
}
