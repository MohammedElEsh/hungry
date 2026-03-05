import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/app_router.dart';
import '../../domain/entities/profile_entity.dart';
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
