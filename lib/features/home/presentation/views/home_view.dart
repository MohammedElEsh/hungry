import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../auth/data/repositories/auth_repo.dart';
import '../../../product/data/models/product_model.dart';
import '../../../product/data/repositories/product_repo.dart';
import '../widgets/categories_list.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/grid_view_section.dart';
import '../../../auth/data/models/user_model.dart';

class HomeView extends StatefulWidget {
  final VoidCallback? onProfileTap;
  const HomeView({super.key, this.onProfileTap});

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
  UserModel? userModel;
  bool isLoading = true;

  ProductRepo productRepo = ProductRepo();
  List<ProductModel>? products = [];

  Future<void> getProducts() async {
    final products = await productRepo.getProducts();
    setState(() => this.products = products);
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
    getProducts();
  }

  Future<void> loadUserData() async {
    try {
      final user = await AuthRepo().getProfileData();
      setState(() {
        userModel = user;
        isLoading = false;
      });
    } catch (e) {
      final errorMessage = e is ApiError ? e.message : e.toString();
      if (mounted) showErrorBanner(context, errorMessage);
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Skeletonizer(
        enabled: isLoading,
        effect: ShimmerEffect(
          baseColor: Colors.grey.shade300.withOpacity(0.3),
          highlightColor: Colors.grey.shade100.withOpacity(0.1),
          duration: const Duration(milliseconds: 1200),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              HomeAppBar(
                imageUrl: userModel?.image,
                userName: userModel?.name,
                onProfileTap: widget.onProfileTap,
              ),
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
                    Gap(25.h),
                  ],
                ),
              ),
              GridViewSection(
                  products: products ?? []
              ),
            ],
          ),
        ),
      ),
    );
  }
}
