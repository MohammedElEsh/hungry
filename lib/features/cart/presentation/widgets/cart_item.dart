import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
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
    final size = SizeConfig(context);

    return Center(
      child: Card(
        color: AppColors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
          width: size.width * 0.9,
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.02,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    widget.imagePath,
                    width: size.width * 0.2,
                    height: size.height * 0.1,
                    fit: BoxFit.cover,
                  ),
                  Gap(size.height * 0.005),
                  SizedBox(
                    width: size.width * 0.3,
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
                        width: size.width * 0.12,
                        height: size.height * 0.06,
                        borderRadius: 12,
                        backgroundColor: AppColors.primary,
                        textColor: AppColors.white,
                      ),
                      Gap(size.height * 0.02),
                      Text(
                        "$quantity",
                        style: AppTextStyles.titleLarge
                      ),
                      Gap(size.height * 0.02),
                      CustomButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: CupertinoIcons.add,
                        width: size.width * 0.12,
                        height: size.height * 0.06,
                        borderRadius: 12,
                        backgroundColor: AppColors.primary,
                        textColor: AppColors.white,
                      ),
                    ],
                  ),
                  Gap(size.height * 0.03),
                  CustomButton(
                    text: "Remove",
                    onPressed: () {
                    },
                    width: size.width * 0.35,
                    height: size.height * 0.05,
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
