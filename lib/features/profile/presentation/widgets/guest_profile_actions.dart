import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';

class GuestProfileActions extends StatelessWidget {
  final VoidCallback? onSignUp;
  final VoidCallback? onLogOut;
  final bool isLoggingOut;

  const GuestProfileActions({
    super.key,
    this.onSignUp,
    this.onLogOut,
    this.isLoggingOut = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            width: 0.7.sw,
            backgroundColor: AppColors.secondary,
            text: 'Sign Up',
            icon: CupertinoIcons.person_add_solid,
            onPressed: onSignUp,
          ),
        ],
      ),
    );
  }
}
