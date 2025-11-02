import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/utils/app_colors.dart';
import 'package:hungry/features/auth/data/repositories/auth_repo.dart';
import 'package:hungry/features/profile/presentation/widgets/profile_actions.dart';
import 'package:hungry/features/profile/presentation/widgets/profile_fields.dart';
import 'package:hungry/features/profile/presentation/widgets/debit_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/app_router.dart';
import '../../../auth/data/models/user_model.dart';
import '../widgets/add_card_button.dart';
import '../widgets/profile_image.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cardController = TextEditingController();

  UserModel? userModel;
  final AuthRepo authRepo = AuthRepo();
  bool isLoading = true;
  bool isLoggingOut = false;


  File? pickedImage;

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  Future<void> getProfileData() async {
    try {
      final userProfile = await authRepo.getProfileData();
      setState(() {
        userModel = userProfile;
        nameController.text = userProfile?.name ?? '';
        emailController.text = userProfile?.email ?? '';
        addressController.text = userProfile?.address ?? '';
        isLoading = false;
      });
    } catch (e) {
      final errorMessage = e is ApiError ? e.message : e.toString();
      if (mounted) showErrorBanner(context, errorMessage);
      setState(() => isLoading = false);
    }
  }

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }

  Future<UserModel?> updateProfileData() async {
    setState(() => isLoading = true);

    try {
      final user = await authRepo.updateProfileData(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        address: addressController.text.trim(),
        visa: cardController.text.trim(),
        image: pickedImage,
      );

      if (!mounted) return null;

      setState(() {
        userModel = user;
        isLoading = false;
      });

      return user;
    } catch (e) {
      final errorMessage = e is ApiError ? e.message : e.toString();

      if (mounted) {
        showErrorBanner(context, errorMessage);
        setState(() => isLoading = false);
      }
      return null;
    }
  }

  Future<void> logout() async {
    setState(() => isLoggingOut = true);

    try {
      await authRepo.logout();
      if (!mounted) return;


      context.go(AppRouter.kLoginView);
    } catch (e) {
      final errorMessage = e is ApiError ? e.message : e.toString();
      if (mounted) showErrorBanner(context, errorMessage);
      setState(() => isLoggingOut = false);
    }
  }

  bool get hasCard {
    return userModel?.visa != null && userModel!.visa!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: AppColors.white,
          scrolledUnderElevation: 0,
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.white,
        body: RefreshIndicator(
          color: AppColors.white,
          backgroundColor: AppColors.primary,
          onRefresh: getProfileData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 25.h),
            child: Skeletonizer(
              enabled: isLoading,
              effect: ShimmerEffect(
                baseColor: Colors.grey.shade800.withOpacity(0.3),
                highlightColor: Colors.grey.shade100.withOpacity(0.1),
                duration: const Duration(milliseconds: 1200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileImage(
                    showUploadButton: true,
                    imageUrl: userModel?.image ?? '',
                    imageFile: pickedImage,
                    onUpload: pickImage,
                  ),
                  Gap(50.h),
                  ProfileFields(
                    nameController: nameController,
                    emailController: emailController,
                    addressController: addressController,
                  ),
                  Gap(20.h),

                  if (hasCard)
                    DebitCard(userModel: userModel)
                  else
                    AddCardButton(
                      cardController: cardController,
                      onPressed: () async {
                        await updateProfileData();
                      },
                    ),

                  Gap(60.h),
                  ProfileActions(
                    onEditProfile: () async {
                      await updateProfileData();
                    },
                    onLogOut: () async {
                      await logout();
                    },
                    isLoggingOut: isLoggingOut,
                  ),
                  Gap(20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
