import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/utils/assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';

class CardItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final double rating;
  final int? productId;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;

  const CardItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.rating,
    this.productId,
    this.isFavorite = false,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) => _CardItemContent(this);
}

class _CardItemContent extends StatelessWidget {
  final CardItem widget;

  const _CardItemContent(this.widget);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Gap(10.h),

          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                child: SizedBox(
                  height: 120.h,
                  width: double.infinity,
                    child: Image.network(
                    widget.imagePath,
                    fit: BoxFit.cover,
                    // loadingBuilder: (context, child, loadingProgress) {
                    //   if (loadingProgress == null) {
                    //     return child;
                    //   }
                    //   return Center(
                    //     child: CircularProgressIndicator(
                    //       value: loadingProgress.expectedTotalBytes != null
                    //           ? loadingProgress.cumulativeBytesLoaded /
                    //                 loadingProgress.expectedTotalBytes!
                    //           : null,
                    //     ),
                    //   );
                    // },
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(AssetsData.burger, fit: BoxFit.cover);
                    },
                  ),
                ),
              ),
              Positioned(
                top: 10.h,
                right: 10.w,
                child: GestureDetector(
                  onTap: widget.onFavoriteTap,
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.isFavorite
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      color: widget.isFavorite ? AppColors.error : AppColors.primary,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10.h,
                left: 10.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 14.sp,
                      ),
                      Gap(2.w),
                      Text(
                        widget.rating.toString(),
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                Gap(6.h),
                Text(
                  widget.price,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w900,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
