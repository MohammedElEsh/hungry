import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/styles.dart';

class CartItem extends StatefulWidget {
  final String imagePath;
  final String title;
  final String price;

  const CartItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
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
                  Image.asset(
                    widget.imagePath,
                    width: 80.w,
                    height: 80.h,
                    fit: BoxFit.cover,
                  ),
                  Gap(5.h),
                  SizedBox(
                    width: 120.w,
                    child: Text(
                      widget.title,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  Text(
                    widget.price,
                    style: AppTextStyles.titleSmall.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) quantity--;
                          });
                        },
                        icon: CupertinoIcons.minus,
                        width: 45.w,
                        height: 40.h,
                        borderRadius: 12,
                        backgroundColor: AppColors.primary,
                        textColor: AppColors.white,
                      ),
                      Gap(10.w),
                      Text("$quantity", style: AppTextStyles.titleLarge),
                      Gap(10.w),
                      CustomButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: CupertinoIcons.add,
                        width: 45.w,
                        height: 40.h,
                        borderRadius: 12,
                        backgroundColor: AppColors.primary,
                        textColor: AppColors.white,
                      ),
                    ],
                  ),
                  Gap(20.h),
                  CustomButton(
                    text: "Remove",
                    onPressed: () {},
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
