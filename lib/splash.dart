import 'package:flutter/material.dart';
import 'package:hungry/core/utils/assets.dart';
import 'core/constants/app_colors.dart';
import 'core/utils/styles.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double topPosition = 0;
  bool showText = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
            (timestamp)
      {
      setState(()
      {
        topPosition = MediaQuery.of(context).size.height * 0.665;
        showText = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final imagesWidth = width;
    final imagesHeight = imagesWidth * (348 / 439);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            top: topPosition == 0 ? size.height : topPosition,
            child: SizedBox(
              width: imagesWidth,
              height: imagesHeight,
              child: Image.asset(
                AssetsData.pngwing,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Center(
            child: AnimatedOpacity(
              duration: const Duration(seconds: 2),
              opacity: showText ? 1 : 0,
              child: AnimatedSlide(
                duration: const Duration(seconds: 2),
                curve: Curves.easeOut,
                offset: showText ? Offset.zero : const Offset(0, 1),
                child: Text(
                  "HUNGRY?",
                  style: Styles.heading,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
