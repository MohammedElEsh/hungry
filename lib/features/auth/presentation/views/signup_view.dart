import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/size_config.dart';
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

    final sizeConfig = SizeConfig(context);

    return GestureDetector(
      // onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 0.05),
            child: Form(
              key: formKey,



              child: Column(
                children: [
                  Gap(sizeConfig.height * 0.1),
                  Text(
                    "HUNGRY?",
                    style: AppTextStyles.displayLarge,
                  ),
                  Text(
                    "Join us and explore delicious fast food!",
                    style: AppTextStyles.titleMedium,
                  ),

                  Gap(sizeConfig.height * 0.06),

                  CustomTextField(
                    controller: nameController,
                    hintText: 'Full Name',
                    isPassword: false,
                  ),

                  Gap(sizeConfig.height * 0.02),

                  CustomTextField(
                    controller: emailController,
                    hintText: 'Email Address',
                    isPassword: false,
                  ),
                  Gap(sizeConfig.height * 0.02),

                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    isPassword: true,
                  ),
                  Gap(sizeConfig.height * 0.02),

                  CustomTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    isPassword: true,
                  ),

                  Gap(sizeConfig.height * 0.06),

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

                  Gap(sizeConfig.height * 0.03),

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
                  Gap(sizeConfig.height * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
