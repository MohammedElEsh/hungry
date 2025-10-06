import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/size_config.dart';
import '../widgets/card_item.dart';
import '../widgets/categories_list.dart';
import '../widgets/header_section.dart';
import '../widgets/search_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<String> categories = [
    'All',
    'Fast Food',
    'Pizza',
    'Burgers',
    'Sushi',
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final sizeConfig = SizeConfig(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderSection(),
            Gap(sizeConfig.height * 0.04),
            SearchField(),
            Gap(sizeConfig.height * 0.04),
            CategoriesList(
              categories: categories,
              currentIndex: currentIndex,
              onCategoryTap: (index) {
                setState(() => currentIndex = index);
              },

            ),
            Gap(sizeConfig.height * 0.04),




            CardItem(
              imagePath: AssetsData.pngwing,
              title: "Cheeseburger",
              price: "12.99 \$",
              rating: 4.7,
            ),

          ],
        ),
      ),
    );
  }
}
