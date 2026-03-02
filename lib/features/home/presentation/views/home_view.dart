import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../auth/data/repositories/auth_repo.dart';
import '../../../cart/data/repositories/cart_repo.dart';
import '../../../product/data/models/product_model.dart';
import '../../../product/data/repositories/product_repo.dart';
import '../../data/models/category_model.dart';
import '../../data/repositories/category_repo.dart';
import '../../data/repositories/favorite_repo.dart';
import '../widgets/categories_list.dart';
import '../widgets/grid_view_section.dart';
import '../widgets/home_app_bar.dart';
import '../../../auth/data/models/user_model.dart';

class HomeView extends StatefulWidget {
  final VoidCallback? onProfileTap;
  final VoidCallback? onCartTap;

  const HomeView({super.key, this.onProfileTap, this.onCartTap});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  UserModel? userModel;
  bool isLoading = true;

  final ProductRepo _productRepo = ProductRepo();
  final CategoryRepo _categoryRepo = CategoryRepo();
  final FavoriteRepo _favoriteRepo = FavoriteRepo();
  final CartRepo _cartRepo = CartRepo();
  final AuthRepo _authRepo = AuthRepo();
  List<ProductModel>? products = [];
  List<CategoryModel> categories = [];
  Set<int> _favoriteIds = {};
  int _cartItemCount = 0;

  Future<void> _loadCategories() async {
    try {
      final list = await _categoryRepo.getCategories();
      if (mounted) {
        setState(() => categories = list);
      }
    } catch (e) {
      if (mounted) {
        setState(() => categories = []);
      }
    }
  }

  Future<void> _loadProducts() async {
    final list = await _productRepo.getProducts();
    if (mounted) setState(() => products = list);
  }

  Future<void> _loadCartCount() async {
    try {
      final cart = await _cartRepo.getCart();
      if (mounted) {
        setState(() => _cartItemCount = cart.items.length);
      }
    } catch (_) {
      if (mounted) setState(() => _cartItemCount = 0);
    }
  }

  Future<void> _loadFavorites() async {
    if (_authRepo.isGuest) return;
    try {
      final ids = await _favoriteRepo.getFavorites();
      if (mounted) setState(() => _favoriteIds = ids.toSet());
    } catch (_) {
      if (mounted) setState(() => _favoriteIds = {});
    }
  }

  Future<void> _toggleFavorite(int productId) async {
    if (_authRepo.isGuest) return;
    final wasFavorite = _favoriteIds.contains(productId);
    setState(() {
      if (wasFavorite) {
        _favoriteIds = {..._favoriteIds}..remove(productId);
      } else {
        _favoriteIds = {..._favoriteIds, productId};
      }
    });
    try {
      await _favoriteRepo.toggleFavorite(productId);
    } catch (e) {
      if (mounted) {
        setState(() {
          if (wasFavorite) {
            _favoriteIds = {..._favoriteIds, productId};
          } else {
            _favoriteIds = {..._favoriteIds}..remove(productId);
          }
        });
        showErrorBanner(context, e is ApiError ? e.message : e.toString());
      }
    }
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
  void initState() {
    super.initState();
    loadUserData();
    _loadCategories();
    _loadProducts();
    _loadFavorites();
    _loadCartCount();
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
                favoriteCount: _favoriteIds.length,
                cartItemCount: _cartItemCount,
                onCartTap: widget.onCartTap,
                onFavoritesTap: null,
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategoriesList(
                      categories: ['All', ...categories.map((c) => c.name)],
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
                products: isLoading
                    ? List.generate(
                        6,
                        (index) => ProductModel(
                          name: "Loading Name",
                          price: "00",
                          rating: "0.0",
                          image: "",
                        ),
                      )
                    : (products ?? []),
                favoriteIds: _favoriteIds,
                onFavoriteTap: _authRepo.isGuest ? null : _toggleFavorite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
