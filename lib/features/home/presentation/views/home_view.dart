import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../widgets/categories_list.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/grid_view_section.dart';

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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const HomeAppBar(),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategoriesList(
                    categories: categories,
                    currentIndex: currentIndex,
                    onCategoryTap: (index) {
                      setState(() => currentIndex = index);
                    },
                  ),
                  Gap(24.h),
                ],
              ),
            ),
            const GridViewSection(),
          ],
        ),
      ),
    );
  }
}
