import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/profile_cubit.dart';

/// Error state view: message + retry. No business logic.
class ProfileErrorView extends StatelessWidget {
  final String message;

  const ProfileErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: () => context.read<ProfileCubit>().loadProfile(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
