import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/utils/app_colors.dart';

class ProfileImage extends StatelessWidget {
  final String? imageUrl;
  final File? imageFile;
  final double? height;
  final double? width;
  final VoidCallback? onUpload;
  final bool showUploadButton;

  const ProfileImage({
    super.key,
    this.imageUrl,
    this.imageFile,
    this.height,
    this.width,
    this.onUpload,
    required this.showUploadButton,
  });

  @override
  Widget build(BuildContext context) {
    final hasLocalImage = imageFile != null;

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: height ?? 120.h,
            width: width ?? 120.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white, width: 3.w),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],

              image: hasLocalImage
                  ? DecorationImage(
                      image: FileImage(imageFile!),
                      fit: BoxFit.cover,
                    )
                  : (imageUrl != null && imageUrl!.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(imageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null),

              color: AppColors.primary,
            ),
          ),

          if (showUploadButton)

            Positioned(
            bottom: -5.h,
            right: -5.w,
            child: GestureDetector(
              onTap: onUpload,
              child: Container(
                height: 25.h,
                width: 25.w,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 2.w),
                ),
                child: Center(
                  child: Icon(
                    CupertinoIcons.add,
                    color: AppColors.white,
                    size: 16.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
