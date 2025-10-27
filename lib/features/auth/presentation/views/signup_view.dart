import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/features/auth/data/repositories/auth_repo.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/styles.dart';
import 'package:gap/gap.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthRepo authRepo = AuthRepo();
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        if (passwordController.text != confirmPasswordController.text) {
          showErrorBanner(context, 'Passwords do not match');
        } else {
          await authRepo.register(
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

          // ignore: use_build_context_synchronously
          context.go(AppRouter.kHomeView);
          // ignore: use_build_context_synchronously
          showSuccessBanner(context, 'Account created successfully!');
        }
      } catch (e) {
        final errorMessage = e is ApiError ? e.message : e.toString();
        // ignore: use_build_context_synchronously
        showErrorBanner(context, errorMessage);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      showErrorBanner(context, 'Please fill all fields correctly');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SingleChildScrollView(
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
                  validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                ),
                Gap(16.h),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Email Address',
                  isPassword: false,
                  validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
                ),
                Gap(16.h),
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  isPassword: true,
                  validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
                ),
                Gap(16.h),
                CustomTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  isPassword: true,
                  validator: (value) => value!.isEmpty ? 'Please confirm your password' : null,
                ),
                Gap(50.h),
                isLoading
                    ? const CupertinoActivityIndicator(
                    color: AppColors.white,
                )
                    : CustomButton(
                  text: isLoading ? 'Loading...' : 'Signup',
                  onPressed: signUp,
                ),
                Gap(20.h),
                // CustomButton(
                //   text: 'Sign Up',
                //   onPressed: signUp,
                // ),
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
    );
  }
}
