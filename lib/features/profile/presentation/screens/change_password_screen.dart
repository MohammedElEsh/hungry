import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/styles.dart';
import '../../../auth/presentation/widgets/custom_text_field.dart';
import '../../../../core/components/custom_button.dart';
import '../../domain/usecases/change_password_usecase.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final current = _currentController.text.trim();
    final newPwd = _newController.text.trim();
    final confirm = _confirmController.text.trim();
    if (newPwd != confirm) {
      if (mounted) {
        showErrorBanner(context, 'please_confirm_password'.tr());
      }
      return;
    }
    setState(() => _isLoading = true);
    final result = await sl<ChangePasswordUseCase>()(current, newPwd);
    if (!mounted) return;
    setState(() => _isLoading = false);
    result.when(
      success: (_) {
        showSuccessBanner(context, 'success'.tr());
        context.pop();
      },
      onFailure: (f) {
        final msg = f.message.contains('not_available') ||
                f.message.contains('change_password')
            ? 'change_password_not_available'.tr()
            : f.message;
        showErrorBanner(context, msg);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('change_password'.tr()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gap(24.h),
              Text(
                'password'.tr(),
                style: AppTextStyles.titleMedium.copyWith(color: AppColors.grey),
              ),
              Gap(8.h),
              CustomTextField(
                controller: _currentController,
                hintText: 'password'.tr(),
                isPassword: true,
                validator: (v) =>
                    v == null || v.isEmpty ? 'password_is_required'.tr() : null,
              ),
              Gap(20.h),
              Text(
                'new_password'.tr(),
                style: AppTextStyles.titleMedium.copyWith(color: AppColors.grey),
              ),
              Gap(8.h),
              CustomTextField(
                controller: _newController,
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
              Gap(40.h),
              CustomButton(
                text: 'submit'.tr(),
                onPressed: _isLoading ? null : _submit,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
