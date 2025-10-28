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

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthRepo authRepo = AuthRepo();
  bool isLoading = false;


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    emailController.text = 'sksk@gmail.com';
    passwordController.text = '123456789';
    super.initState();
  }


  // Login function with state management for loading
  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        await authRepo.login(
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        // ignore: use_build_context_synchronously
        context.go(AppRouter.kHomeView);
        // ignore: use_build_context_synchronously
        showSuccessBanner(context, 'Login Successful');
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
      // Show error banner if form validation fails
      showErrorBanner(context, 'Please fill in all fields correctly');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                  "Welcome Back, Discover The Fast Food",
                  style: AppTextStyles.titleMedium,
                  textAlign: TextAlign.center,
                ),
                Gap(60.h),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Email Address',
                  isPassword: false,
                  validator: (value) => value!.isEmpty ? 'Email is required' : null,
                ),
                Gap(16.h),
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  isPassword: true,
                  validator: (value) => value!.isEmpty ? 'Password is required' : null,
                ),
                Gap(80.h),
                isLoading
                    ? const CupertinoActivityIndicator(
                    color: AppColors.white

                )
                    : CustomButton(
                  text: isLoading ? 'Loading...' : 'Login',
                  onPressed: login,
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
    );
  }
}
