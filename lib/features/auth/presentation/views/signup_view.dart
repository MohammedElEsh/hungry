import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/features/auth/data/repositories/auth_repo.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/styles.dart';
import '../widgets/signup_form.dart';

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
                    Text("sign up", style: AppTextStyles.displayLarge),
                    Text(
                      "please sign up to get started",
                      style: AppTextStyles.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: SignupForm(
                  nameController: nameController,
                  emailController: emailController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                  formKey: formKey,
                  isLoading: isLoading,
                  signUp: signUp,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
