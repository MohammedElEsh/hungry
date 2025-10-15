import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/styles.dart';
import '../widgets/checkout_summary.dart';
import '../widgets/product_customization.dart';
import '../widgets/side_options_list.dart';
import '../widgets/toppings_list.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  double _value = 0.6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(top: 100.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomizedSection(
                sliderValue: _value,
                onSliderChanged: (value) {
                  setState(() => _value = value);
                },
              ),
              Gap(40.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text("Tappings", style: AppTextStyles.bodyBrown),
              ),
              Gap(15.h),
              const ToppingsList(),
              Gap(30.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text("Side Options", style: AppTextStyles.bodyBrown),
              ),
              Gap(15.h),
              const SideOptionsList(),
              Gap(30.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text("Total", style: AppTextStyles.bodyBrown),
              ),
              const CheckoutSummary(),
              Gap(30.h),
            ],
          ),
        ),
      ),
    );
  }
}
