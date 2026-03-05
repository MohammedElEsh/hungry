import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlideOutImage extends StatefulWidget {
  final String imagePath;
  final double startTop;
  final double aspectRatio;
  final Duration duration;
  final VoidCallback onAnimationEnd;

  const SlideOutImage({
    super.key,
    required this.imagePath,
    required this.startTop,
    required this.onAnimationEnd,
    this.aspectRatio = 348 / 439,
    this.duration = const Duration(seconds: 1),
  });

  @override
  State<SlideOutImage> createState() => _SlideOutImageState();
}

class _SlideOutImageState extends State<SlideOutImage> {
  late double topPosition;

  @override
  void initState() {
    super.initState();
    topPosition = widget.startTop;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        topPosition = 1.sh;
      });
      Future.delayed(widget.duration, widget.onAnimationEnd);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = 1.sw * widget.aspectRatio;

    return AnimatedPositioned(
      duration: widget.duration,
      curve: Curves.easeIn,
      top: topPosition,
      child: SizedBox(
        width: 1.sw,
        height: height,
        child: Image.asset(widget.imagePath, fit: BoxFit.contain),
      ),
    );
  }
}
