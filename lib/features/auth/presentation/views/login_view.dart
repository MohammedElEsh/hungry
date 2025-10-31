import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/features/auth/data/repositories/auth_repo.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/styles.dart';
import '../widgets/login_form.dart';

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
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.primary,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 60.h),
                child: Column(
                  children: [
                    Text("Log in", style: AppTextStyles.displayLarge),
                    Text(
                      "please sign in to your existing account",
                      style: AppTextStyles.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    LoginForm(
                      emailController: emailController,
                      passwordController: passwordController,
                      formKey: formKey,
                      isLoading: isLoading,
                      login: login,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
