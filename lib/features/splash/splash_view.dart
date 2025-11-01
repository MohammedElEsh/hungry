import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/utils/app_colors.dart';
import 'package:hungry/core/utils/app_router.dart';
import 'package:hungry/core/utils/assets.dart';
import 'package:hungry/core/utils/styles.dart';
import 'package:hungry/features/splash/widgets/fade_slide_in_text.dart';
import 'package:hungry/features/splash/widgets/slide_in_image.dart';
import 'package:hungry/features/splash/widgets/fade_slide_out_text.dart';
import 'package:hungry/features/splash/widgets/slide_out_image.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool playOutAnimation = false;
  bool animationTriggered = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (!animationTriggered) {
        startOutAnimation();
      }
    });
  }

  void startOutAnimation() {
    setState(() {
      playOutAnimation = true;
      animationTriggered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (!animationTriggered) {
            startOutAnimation();
          }
        },
        child: Stack(
          children: [
            if (!playOutAnimation)
              SlideInImage(
                imagePath: AssetsData.splash,
                targetTop: 540.h,
              )
            else
              SlideOutImage(
                imagePath: AssetsData.splash,
                startTop: 540.h,
                onAnimationEnd: () {
                  context.go(AppRouter.kLoginView);
                },
              ),
            Center(
              child: !playOutAnimation
                  ? FadeSlideText(
                text: "HUNGRY?",
                style: AppTextStyles.displayLarge,
              )
                  : FadeSlideOutText(
                text: "HUNGRY?",
                style: AppTextStyles.displayLarge,
                onAnimationEnd: () {
                  context.go(AppRouter.kLoginView);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
