import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/utils/assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';

class CardItem extends StatefulWidget {
  final String imagePath;
  final String title;
  final String price;
  final double rating;

  const CardItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.rating,
  });

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 90.h,
                child: Image.network(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (
                      context,
                      error,
                      stackTrace) {
                    return Image.asset(
                      AssetsData.burger,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              Gap(3.h),
              Text(
                widget.title,
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
              Text(
                widget.price,
                style: AppTextStyles.titleSmall.copyWith(color: AppColors.grey),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 20.sp),
                  Gap(4.w),
                  Text(
                    widget.rating.toString(),
                    style: AppTextStyles.titleSmall.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    icon: Icon(
                      isFavorite
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      color: AppColors.error,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
