import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/utils/styles.dart';
import '../widgets/customized_text.dart';
import '../widgets/spicy_slider.dart';
import '../widgets/topping_grid.dart';

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
      body: Padding(
        padding: EdgeInsets.only(
            top: sizeConfig.height * 0.12,
            left: sizeConfig.width * 0.05,
            right: sizeConfig.width * 0.05
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  AssetsData.customizedBurger,
                  height: 300,
                ),
                const Spacer(),
                Column(
                  children: [
                    CustomizedText(),
                    Gap(sizeConfig.height * 0.02),
                    SpicySlider(
                      initialValue: _value,
                      onChanged: (value) {
                        setState(() => _value = value);
                      },
                    ),




                  ],
                ),
              ],
            ),
            Gap(sizeConfig.height * 0.05),
            Padding(
              padding: EdgeInsets.only(left: sizeConfig.width * 0.05),
              child: Text("Tappings",style: AppTextStyles.bodyBlack),
            ),
            Gap(sizeConfig.height * 0.02),
            const ToppingsList(),


          ],
        ),
      ),
    );
  }
}

