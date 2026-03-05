import 'package:flutter/material.dart';

/// Slide-in animation wrapper.
enum SlideDirection {
  fromLeft,
  fromRight,
  fromTop,
  fromBottom,
}

class SlideIn extends StatelessWidget {
  final Widget child;
  final SlideDirection direction;
  final Duration duration;

  const SlideIn({
    super.key,
    required this.child,
    this.direction = SlideDirection.fromBottom,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(
        begin: _beginOffset,
        end: Offset.zero,
      ),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: value,
          child: child,
        );
      },
      child: child,
    );
  }

  Offset get _beginOffset {
    switch (direction) {
      case SlideDirection.fromLeft:
        return const Offset(-50, 0);
      case SlideDirection.fromRight:
        return const Offset(50, 0);
      case SlideDirection.fromTop:
        return const Offset(0, -50);
      case SlideDirection.fromBottom:
        return const Offset(0, 50);
    }
  }
}
