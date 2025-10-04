import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/utils/app_colors.dart';
import 'package:hungry/core/utils/app_router.dart';
import 'package:hungry/core/utils/assets.dart';
import 'package:hungry/core/utils/styles.dart';
import 'package:hungry/core/utils/size_config.dart';
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

  @override
  Widget build(BuildContext context) {
    final sizeConfig = SizeConfig(context);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            playOutAnimation = true;
          });
        },
        child: Stack(
          children: [
            // Image
            if (!playOutAnimation)
              SlideInImage(
                imagePath: AssetsData.pngwing,
                targetTop: sizeConfig.height * 0.665,
              )
            else
              SlideOutImage(
                imagePath: AssetsData.pngwing,
                startTop: sizeConfig.height * 0.665,
                onAnimationEnd: () {
                  context.go(AppRouter.kLoginView);
                },
              ),

            // Text
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
