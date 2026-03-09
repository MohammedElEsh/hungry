import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/offline_banner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../di/injection.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/cart/presentation/widgets/guest_cart_view.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/orders/presentation/screens/orders_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';

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
    final isGuest = sl<AuthRepository>().isGuest;
    final List<Widget> screens = [
      HomeScreen(
        onProfileTap: () => goToPage(3),
        onCartTap: () => goToPage(1),
      ),
      isGuest
          ? const GuestCartView()
          : CartScreen(onHomeTap: () => goToPage(0)),
      OrdersScreen(onHomeTap: () => goToPage(0)),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(
            child: PageView(
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
          ),
        ],
      ),
      bottomNavigationBar: Builder(
        builder: (context) {
          final colorScheme = Theme.of(context).colorScheme;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: colorScheme.primary,
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
                selectedItemColor: colorScheme.onPrimary,
                unselectedItemColor: Colors.grey,
                // unselectedItemColor: colorScheme.onSurfaceVariant,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_sharp),
                label: 'home'.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.shopping_cart),
                label: 'cart'.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.local_restaurant_sharp),
                label: 'orders'.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.profile_circled),
                label: 'profile'.tr(),
              ),
            ],
          ),
        ),
          );
        },
      ),
    );
  }
}
