import 'package:flutter/material.dart';

/// Fade-in animation wrapper.
class FadeIn extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final int delayMillis;

  const FadeIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.delayMillis = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration,
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: child,
    );
  }
}
