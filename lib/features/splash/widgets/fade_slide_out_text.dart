import 'package:flutter/material.dart';

class FadeSlideOutText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;
  final VoidCallback onAnimationEnd;

  const FadeSlideOutText({
    super.key,
    required this.text,
    required this.style,
    required this.onAnimationEnd,
    this.duration = const Duration(seconds: 1),
  });

  @override
  State<FadeSlideOutText> createState() => _FadeSlideOutTextState();
}

class _FadeSlideOutTextState extends State<FadeSlideOutText> {
  bool hide = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        hide = true;
      });
      Future.delayed(widget.duration, widget.onAnimationEnd);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: widget.duration,
      opacity: hide ? 0 : 1,
      child: AnimatedSlide(
        duration: widget.duration,
        curve: Curves.easeIn,
        offset: hide ? const Offset(0, -1) : Offset.zero,
        child: Text(widget.text, style: widget.style),
      ),
    );
  }
}
