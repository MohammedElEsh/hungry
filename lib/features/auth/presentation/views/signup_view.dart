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

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();
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
                    "Join us and explore delicious fast food!",
                    style: AppTextStyles.titleMedium,
                  ),
                  Gap(50.h),
                  CustomTextField(
                    controller: nameController,
                    hintText: 'Full Name',
                    isPassword: false,
                  ),
                  Gap(16.h),
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
                  Gap(16.h),
                  CustomTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    isPassword: true,
                  ),
                  Gap(50.h),
                  CustomButton(
                    text: 'Sign Up',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (passwordController.text != confirmPasswordController.text) {
                          showErrorBanner(context, 'Passwords do not match');
                        } else {
                          showSuccessBanner(context, 'Account created successfully!');
                        }
                      } else {
                        showErrorBanner(context, 'Please fill all fields correctly');
                      }
                    },
                  ),
                  Gap(20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: AppTextStyles.titleMedium,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.go(AppRouter.kLoginView);
                        },
                        child: Text(
                          "Login",
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
