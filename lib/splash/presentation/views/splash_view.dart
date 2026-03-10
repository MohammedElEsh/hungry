import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/di/injection.dart';
import 'package:hungry/core/storage/app_preferences.dart';
import 'package:hungry/core/utils/app_router.dart';
import 'package:hungry/core/utils/assets.dart';
import 'package:hungry/core/utils/styles.dart';
import 'package:hungry/features/auth/domain/repositories/auth_repository.dart';
import 'package:hungry/splash/presentation/widgets/fade_slide_in_text.dart';
import 'package:hungry/splash/presentation/widgets/slide_in_image.dart';
import 'package:hungry/splash/presentation/widgets/fade_slide_out_text.dart';
import 'package:hungry/splash/presentation/widgets/slide_out_image.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool playOutAnimation = false;
  bool animationTriggered = false;
  bool _navigationTriggered = false;

  AuthRepository get _authRepository => sl<AuthRepository>();

  Future<void> _checkAutoLogin() async {
    if (_navigationTriggered) return;
    _navigationTriggered = true;
    final onboardingSeen = await sl<AppPreferences>().isOnboardingSeen();
    if (!mounted) return;
    if (!onboardingSeen) {
      context.go(AppRouter.kOnboardingView);
      return;
    }
    await _authRepository.autoLogin();
    if (!mounted) return;
    if (_authRepository.isLoggedIn || _authRepository.isGuest) {
      context.go(AppRouter.kHomeView);
    } else {
      context.go(AppRouter.kLoginView);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      if (!animationTriggered) startOutAnimation();
    });
  }

  void startOutAnimation() {
    if (animationTriggered) return;
    setState(() {
      playOutAnimation = true;
      animationTriggered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SlideInImage(imagePath: AssetsData.splash, targetTop: 540.h)
          else
            SlideOutImage(
              imagePath: AssetsData.splash,
              startTop: 540.h,
              onAnimationEnd: _checkAutoLogin,
            ),
          Center(
            child: !playOutAnimation
                ? FadeSlideText(
                    text: "HUNGRY?",
                    style: AppTextStyles.displayLarge.copyWith(color: AppColors.primary),
                  )
                :                     FadeSlideOutText(
                    text: "HUNGRY?",
                    style: AppTextStyles.displayLarge,
                    onAnimationEnd: _checkAutoLogin,
                  ),
          ),
        ],
      ),
      ),
    );
  }
}
