import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/size_config.dart';
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

bool isFavorite = false;

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    final sizeConfig = SizeConfig(context);

    return Card(
      color: AppColors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: sizeConfig.width * 0.05,
          vertical: sizeConfig.height * 0.015,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              widget.imagePath,
              width: sizeConfig.width * 0.35,
              height: sizeConfig.height * 0.135,
              fit: BoxFit.cover,
            ),
            Gap(sizeConfig.height * 0.001),
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
            Gap(sizeConfig.height * 0.005),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: sizeConfig.width * 0.055,
                ),
                Gap(sizeConfig.width * 0.01),
                Text(
                  widget.rating.toString(),
                  style: AppTextStyles.titleSmall.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                Spacer(),
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
                    size: sizeConfig.width * 0.055,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
