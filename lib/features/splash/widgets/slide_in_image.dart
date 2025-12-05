import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlideInImage extends StatefulWidget {
  final String imagePath;
  final double targetTop;
  final double aspectRatio;
  final Duration duration;

  const SlideInImage({
    super.key,
    required this.imagePath,
    required this.targetTop,
    this.aspectRatio = 348 / 439,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<SlideInImage> createState() => _SlideInImageState();
}

class _SlideInImageState extends State<SlideInImage> {
  double topPosition = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        topPosition = widget.targetTop;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final imgHeight = 1.sw * widget.aspectRatio;

    return AnimatedPositioned(
      duration: widget.duration,
      curve: Curves.fastOutSlowIn,
      top: topPosition == 0 ? 1.sh : widget.targetTop,
      child: SizedBox(
        width: 1.sw,
        height: imgHeight,
        child: Image.asset(widget.imagePath, fit: BoxFit.contain),
      ),
    );
  }
}
