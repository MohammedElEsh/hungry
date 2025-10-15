import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/styles.dart';
import 'package:gap/gap.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return GestureDetector(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Gap(80.h),
                  Text("HUNGRY?", style: AppTextStyles.displayLarge),
                  Text(
                    "Welcome Back, Discover The Fast Food",
                    style: AppTextStyles.titleMedium,
                  ),
                  Gap(60.h),
                  CustomTextField(
                    controller: emailController,
                    hintText: 'Email Address',
                    isPassword: false,
                  ),
                  Gap(16.h),
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    isPassword: true,
                  ),
                  Gap(80.h),
                  CustomButton(
                    text: 'Login',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        showSuccessBanner(context, 'Form is valid');
                        context.go(AppRouter.kHomeView);
                      } else {
                        showErrorBanner(context, 'Form is invalid');
                      }
                    },
                  ),
                  Gap(20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account? ",
                        style: AppTextStyles.titleMedium,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go(AppRouter.kSignupView);
                        },
                        child: Text(
                          "Sign Up",
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
