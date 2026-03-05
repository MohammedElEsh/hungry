import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Shared shimmer effect used for skeleton loading across the app.
ShimmerEffect get skeletonShimmerEffect => ShimmerEffect(
      baseColor: Colors.grey.shade300.withOpacity(0.3),
      highlightColor: Colors.grey.shade100.withOpacity(0.1),
      duration: const Duration(milliseconds: 1200),
    );

/// Wraps [child] in [Skeletonizer] with the app's standard shimmer when [enabled].
Widget skeletonize({
  required bool enabled,
  required Widget child,
  ShimmerEffect? effect,
}) {
  return Skeletonizer(
    enabled: enabled,
    effect: effect ?? skeletonShimmerEffect,
    child: child,
  );
}
