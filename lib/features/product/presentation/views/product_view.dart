import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/size_config.dart';
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
    final sizeConfig = SizeConfig(context);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(top: sizeConfig.height * 0.12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomizedSection(
                sliderValue: _value,
                onSliderChanged: (value) {
                  setState(() => _value = value);
                },
              ),

              Gap(sizeConfig.height * 0.05),
              Padding(
                padding: EdgeInsets.only(left: sizeConfig.width * 0.05),
                child: Text("Tappings", style: AppTextStyles.bodyBrown),
              ),
              Gap(sizeConfig.height * 0.02),
              const ToppingsList(),

              Gap(sizeConfig.height * 0.04),
              Padding(
                padding: EdgeInsets.only(left: sizeConfig.width * 0.05),
                child: Text("Side Options", style: AppTextStyles.bodyBrown),
              ),
              Gap(sizeConfig.height * 0.02),
              const SideOptionsList(),
              Gap(sizeConfig.height * 0.04),

              Padding(
                padding: EdgeInsets.only(left: sizeConfig.width * 0.05),
                child: Text("Total", style: AppTextStyles.bodyBrown),
              ),

              const CheckoutSummary(),
              Gap(sizeConfig.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}