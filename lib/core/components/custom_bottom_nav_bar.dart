import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/orders/presentation/screens/orders_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../constants/app_colors.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void goToPage(int index) {
    if (index == currentIndex) return;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 380),
      curve: Curves.easeOutCubic,
    );
    // currentIndex updates in onPageChanged so the nav indicator stays in sync with the page animation
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(
        onProfileTap: () => goToPage(3),
        onCartTap: () => goToPage(1),
      ),
      CartScreen(onHomeTap: () => goToPage(0)),
      OrdersScreen(onHomeTap: () => goToPage(0)),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          if (currentIndex != index) {
            setState(() => currentIndex = index);
          }
          if (index == 0) {
            context.read<HomeCubit>().refresh();
            context.read<CartCubit>().loadCart();
          } else if (index == 1) {
            context.read<CartCubit>().loadCart();
          }
        },
        children: screens,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: currentIndex,
            onTap: (index) => goToPage(index),
            backgroundColor: Colors.transparent,
            selectedItemColor: AppColors.white,
            unselectedItemColor: AppColors.grey,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_sharp),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_restaurant_sharp),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.profile_circled),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
