import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../cubit/profile_cubit.dart';
import '../handlers/profile_controllers.dart';
import '../handlers/profile_handlers.dart';
import '../listeners/profile_listener.dart';
import '../views/profile_view_factory.dart';

/// Profile feature screen: Scaffold + BlocConsumer, controllers, dispose.
/// All side-effects in listener/handlers; views from ProfileViewFactory.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileControllers _controllers = ProfileControllers();
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<ProfileCubit>().loadProfile();
    });
  }

  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  Future<void> _onUpload() async {
    final file = await ProfileHandlers.pickImage();
    if (file != null && mounted) setState(() => _pickedImage = file);
  }

  Future<void> _onUpdate() async {
    await ProfileHandlers.updateProfile(
      context,
      cubit: context.read<ProfileCubit>(),
      controllers: _controllers,
      imageFile: _pickedImage,
    );
    if (mounted) setState(() => _pickedImage = null);
  }

  Future<void> _onLogOut({required bool isGuest}) async {
    await ProfileHandlers.logout(
      context,
      cubit: context.read<ProfileCubit>(),
      isGuest: isGuest,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // appBar: AppBar(
        //   toolbarHeight: 48.h,
        //   backgroundColor: AppColors.white,
        //   scrolledUnderElevation: 0,
        // ),
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.white,
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) =>
              handleProfileState(context, state, _controllers),
          listenWhen: (prev, next) =>
              next is ProfileLoaded ||
              next is ProfileError ||
              next is ProfileUpdateFailed,
          buildWhen: (prev, next) => true,
          builder: (context, state) {
            return ProfileViewFactory.build(
              context,
              state,
              controllers: _controllers,
              pickedImage: _pickedImage,
              onUpload: _onUpload,
              onUpdate: _onUpdate,
              onLogOut: () => _onLogOut(isGuest: false),
              onGuestLogOut: () => _onLogOut(isGuest: true),
              onSignUp: () => context.go(AppRouter.kSignupView),
            );
          },
        ),
      ),
    );
  }
}
