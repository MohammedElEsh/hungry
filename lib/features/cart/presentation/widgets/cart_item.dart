import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/components/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../data/models/cart_model.dart';

class CartItemWidget extends StatelessWidget {
  final CartDisplayItem item;
  final VoidCallback onRemove;

  const CartItemWidget({super.key, required this.item, required this.onRemove});

  String _getItemTotal(CartDisplayItem item) {
    final unitPrice = double.tryParse(item.price) ?? 0;
    final total = unitPrice * item.quantity;
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final item = this.item;
    final imageUrl = item.image ?? '';

    return Center(
      child: Card(
        color: AppColors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Container(
          width: 0.9.sw,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imageUrl.isNotEmpty)
                    Image.network(
                      imageUrl,
                      width: 80.w,
                      height: 80.h,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 80.w,
                        height: 80.h,
                        color: AppColors.grey.withOpacity(0.3),
                        child: Icon(Icons.fastfood, size: 40.sp),
                      ),
                    )
                  else
                    Container(
                      width: 80.w,
                      height: 80.h,
                      color: AppColors.grey.withOpacity(0.3),
                      child: Icon(Icons.fastfood, size: 40.sp),
                    ),
                  Gap(5.h),
                  SizedBox(
                    width: 120.w,
                    child: Text(
                      item.name,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  Text(
                    '\$${_getItemTotal(item)}',
                    style: AppTextStyles.titleSmall.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Qty: ${item.quantity}',
                    style: AppTextStyles.titleLarge,
                  ),
                  Gap(20.h),
                  CustomButton(
                    text: 'Remove',
                    onPressed: onRemove,
                    width: 120.w,
                    height: 40.h,
                    borderRadius: 20,
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.white,
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
