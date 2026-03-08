import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/app_router.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/usecases/delete_account_usecase.dart';
import '../cubit/profile_cubit.dart';
import 'profile_controllers.dart';

/// Side-effect handlers: image picker, update profile, logout. No UI.
class ProfileHandlers {
  const ProfileHandlers._();

  static Future<File?> pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    return image != null ? File(image.path) : null;
  }

  static Future<void> updateProfile(
    BuildContext context, {
    required ProfileCubit cubit,
    required ProfileControllers controllers,
    required File? imageFile,
  }) async {
    final state = cubit.state;
    if (state is! ProfileLoaded) return;
    final profile = ProfileEntity(
      id: state.profile.id,
      name: controllers.name.text.trim(),
      email: controllers.email.text.trim(),
      address: controllers.address.text.trim().isEmpty
          ? null
          : controllers.address.text.trim(),
      visa: controllers.card.text.trim().isEmpty ? null : controllers.card.text.trim(),
      image: state.profile.image,
    );
    await cubit.update(profile, imageFile: imageFile);
  }

  static Future<void> deleteAccount(
    BuildContext context, {
    required ProfileCubit cubit,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('delete_account'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('delete_account_confirm'.tr()),
            const SizedBox(height: 8),
            Text(
              'delete_account_warning'.tr(),
              style: TextStyle(
                color: Theme.of(ctx).colorScheme.error,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('cancel'.tr()),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.error,
            ),
            child: Text('delete_account'.tr()),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    final result = await sl<DeleteAccountUseCase>()();
    if (!context.mounted) return;
    result.when(
      success: (_) {
        if (!context.mounted) return;
        context.go(AppRouter.kLoginView);
        showSuccessBanner(context, 'success'.tr());
      },
      onFailure: (f) {
        final msg = f.message.contains('not_available')
            ? 'delete_account_not_available'.tr()
            : f.message;
        showErrorBanner(context, msg);
      },
    );
  }

  static Future<void> logout(
    BuildContext context, {
    required ProfileCubit cubit,
    required bool isGuest,
  }) async {
    final success = await cubit.logout();
    if (!context.mounted) return;
    if (success) {
      context.go(AppRouter.kLoginView);
      showSuccessBanner(
        context,
        isGuest ? 'Guest session ended' : 'Logged out successfully',
      );
    }
  }
}
