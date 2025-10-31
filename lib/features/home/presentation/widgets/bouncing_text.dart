import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/styles.dart';

class BouncingText extends StatefulWidget {
  final List<String> letters;
  final List<Color> colors;
  final double fontSize;
  final int delay;

  const BouncingText({
    super.key,
    required this.letters,
    required this.colors,
    this.fontSize = 50,
    this.delay = 400,
  });

  @override
  State<BouncingText> createState() => _BouncingTextState();
}

class _BouncingTextState extends State<BouncingText>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(widget.letters.length, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 800),
      );
    });

    _animations = _controllers.map((controller) {
      return Tween<double>(
        begin: -100.h,
        end: 0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));
    }).toList();

    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * widget.delay), () {
        _controllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.letters.length, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animations[index].value),
              child: Text(
                widget.letters[index],
                style: AppTextStyles.displayLarge.copyWith(
                  color: widget.colors[index],
                  fontSize: widget.fontSize.sp,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
