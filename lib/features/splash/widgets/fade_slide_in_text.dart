import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FadeSlideText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;

  const FadeSlideText({
    super.key,
    required this.text,
    required this.style,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<FadeSlideText> createState() => _FadeSlideTextState();
}

class _FadeSlideTextState extends State<FadeSlideText> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        show = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: widget.duration,
      opacity: show ? 1 : 0,
      child: AnimatedSlide(
        duration: widget.duration,
        curve: Curves.easeOut,
        offset: show ? Offset.zero : Offset(0, 1.h),
        child: Text(widget.text, style: widget.style),
      ),
    );
  }
}
