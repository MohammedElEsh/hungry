import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/widgets/skeleton_loading.dart';
import '../../../../core/utils/styles.dart';
import '../../domain/entities/side_option_entity.dart';
import '../../domain/entities/topping_entity.dart';
import '../widgets/checkout_summary.dart';
import '../widgets/product_customization.dart';
import '../widgets/side_options_list.dart';
import '../widgets/toppings_list.dart';

/// Skeleton view shown while product detail is loading.
class ProductLoadingView extends StatelessWidget {
  const ProductLoadingView({super.key});

  static const List<ToppingEntity> _skeletonToppings = [
    ToppingEntity(id: 0, name: 'Loading', image: ''),
    ToppingEntity(id: 1, name: 'Loading', image: ''),
    ToppingEntity(id: 2, name: 'Loading', image: ''),
  ];
  static const List<SideOptionEntity> _skeletonSideOptions = [
    SideOptionEntity(id: 0, name: 'Loading', image: ''),
    SideOptionEntity(id: 1, name: 'Loading', image: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: skeletonize(
        enabled: true,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomizedSection(
                  sliderValue: 0,
                  onSliderChanged: (_) {},
                  quantity: 1,
                  onIncrement: () {},
                  onDecrement: () {},
                ),
                Gap(20.h),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Text('toppings'.tr(), style: AppTextStyles.bodyBrown),
                ),
                Gap(15.h),
                ToppingsList(
                  toppings: _skeletonToppings,
                  selectedIds: const {},
                  onToppingTapped: (_) {},
                ),
                Gap(30.h),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Text('side_options'.tr(), style: AppTextStyles.bodyBrown),
                ),
                Gap(15.h),
                SideOptionsList(
                  items: _skeletonSideOptions,
                  selectedIds: const {},
                  onSideOptionTapped: (_) {},
                ),
                Gap(30.h),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Text('total'.tr(), style: AppTextStyles.bodyBrown),
                ),
                CheckoutSummary(
                  price: '0.00',
                  onAddToCart: () {},
                  isLoading: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
