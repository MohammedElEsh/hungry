import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/utils/app_colors.dart';
import 'package:hungry/features/auth/data/repositories/auth_repo.dart';
import 'package:hungry/features/profile/presentation/widgets/profile_bottom_sheet.dart';
import 'package:hungry/features/profile/presentation/widgets/profile_fields.dart';
import 'package:hungry/features/profile/presentation/widgets/debit_card.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/utils/alerts.dart';
import '../../../auth/data/models/user_model.dart';
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

  UserModel? userModel;
  final AuthRepo authRepo = AuthRepo();
  bool isLoading = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primary,
      body: RefreshIndicator(
        color: AppColors.white,
        backgroundColor: AppColors.primary,
        onRefresh: getProfileData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 80.h),
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
                ProfileImage(imageUrl: userModel?.image ?? ''),
                Gap(50.h),
                ProfileFields(
                  nameController: nameController,
                  emailController: emailController,
                  addressController: addressController,
                ),
                DebitCard(userModel: userModel),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: const ProfileBottomSheet(),
    );
  }
}
