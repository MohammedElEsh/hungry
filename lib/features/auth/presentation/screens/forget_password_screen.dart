import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/styles.dart';
import '../../domain/usecases/request_password_reset_otp_usecase.dart';
import '../../domain/usecases/reset_password_with_otp_usecase.dart';
import '../../../../core/components/custom_button.dart';
import '../widgets/custom_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  int _step = 1;
  String _email = '';
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      showErrorBanner(context, 'email_is_required'.tr());
      return;
    }
    setState(() => _isLoading = true);
    final result = await sl<RequestPasswordResetOtpUseCase>()(email);
    if (!mounted) return;
    setState(() => _isLoading = false);
    result.when(
      success: (_) {
        setState(() {
          _step = 2;
          _email = email;
        });
        showSuccessBanner(context, 'otp_sent_success'.tr());
      },
      onFailure: (f) {
        final msg = f.message.contains('will be available')
            ? 'forget_password_not_available'.tr()
            : f.message;
        showErrorBanner(context, msg);
      },
    );
  }

  Future<void> _resetPassword() async {
    final otp = _otpController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();
    if (otp.isEmpty) {
      showErrorBanner(context, 'enter_otp'.tr());
      return;
    }
    if (password.isEmpty) {
      showErrorBanner(context, 'please_enter_password'.tr());
      return;
    }
    if (password != confirm) {
      showErrorBanner(context, 'please_confirm_password'.tr());
      return;
    }
    setState(() => _isLoading = true);
    final result = await sl<ResetPasswordWithOtpUseCase>()(_email, otp, password);
    if (!mounted) return;
    setState(() => _isLoading = false);
    result.when(
      success: (_) {
        showSuccessBanner(context, 'success'.tr());
        context.go(AppRouter.kLoginView);
      },
      onFailure: (f) {
        final msg = f.message.contains('will be available')
            ? 'forget_password_not_available'.tr()
            : f.message;
        showErrorBanner(context, msg);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('reset_password'.tr()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_step == 2) {
              setState(() => _step = 1);
            } else {
              context.go(AppRouter.kLoginView);
            }
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: _step == 1 ? _buildStep1() : _buildStep2(),
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Gap(32.h),
        Text(
          'email_address'.tr(),
          style: AppTextStyles.titleMedium.copyWith(color: AppColors.grey),
        ),
        Gap(8.h),
        CustomTextField(
          controller: _emailController,
          hintText: 'email_address'.tr(),
          isPassword: false,
          validator: (v) =>
              v == null || v.isEmpty ? 'email_is_required'.tr() : null,
        ),
        Gap(32.h),
        CustomButton(
          text: 'send_otp'.tr(),
          onPressed: _isLoading ? null : _sendOtp,
          isLoading: _isLoading,
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Gap(16.h),
          Text(
            'otp_sent_success'.tr(),
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
          ),
          Gap(24.h),
          Text(
            'enter_otp'.tr(),
            style: AppTextStyles.titleMedium.copyWith(color: AppColors.grey),
          ),
          Gap(8.h),
          CustomTextField(
            controller: _otpController,
            hintText: 'otp'.tr(),
            isPassword: false,
            validator: (v) =>
                v == null || v.isEmpty ? 'enter_otp'.tr() : null,
          ),
          Gap(20.h),
          Text(
            'new_password'.tr(),
            style: AppTextStyles.titleMedium.copyWith(color: AppColors.grey),
          ),
          Gap(8.h),
          CustomTextField(
            controller: _passwordController,
            hintText: 'password'.tr(),
            isPassword: true,
            validator: (v) =>
                v == null || v.isEmpty ? 'please_enter_password'.tr() : null,
          ),
          Gap(20.h),
          Text(
            'confirm_password'.tr(),
            style: AppTextStyles.titleMedium.copyWith(color: AppColors.grey),
          ),
          Gap(8.h),
          CustomTextField(
            controller: _confirmController,
            hintText: 'confirm_password'.tr(),
            isPassword: true,
            validator: (v) =>
                v == null || v.isEmpty ? 'please_confirm_password'.tr() : null,
          ),
          Gap(32.h),
          CustomButton(
            text: 'reset_password'.tr(),
            onPressed: _isLoading ? null : _resetPassword,
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }
}
