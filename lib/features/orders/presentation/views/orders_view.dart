import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../auth/data/repositories/auth_repo.dart';
import '../../data/models/order_model.dart';
import '../../data/repositories/order_repo.dart';
import '../widgets/empty_orders_view.dart';
import '../widgets/guest_orders_view.dart';
import '../widgets/order_card.dart';

class OrdersView extends StatefulWidget {
  final VoidCallback onHomeTap;

  const OrdersView({super.key, required this.onHomeTap});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final AuthRepo _authRepo = AuthRepo();
  final OrderRepo _orderRepo = OrderRepo();
  List<OrderModel> _orders = [];
  bool _isLoading = true;
  String? _error;

  Future<void> _loadOrders() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final orders = await _orderRepo.getOrders();
      if (mounted) {
        setState(() {
          _orders = orders;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _refreshOrders() async {
    await _loadOrders();
  }

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    // If user is guest, show guest orders view
    if (_authRepo.isGuest) {
      return const GuestOrdersView();
    }

    if (_isLoading && _orders.isEmpty) {
      final placeholders = [
        for (int i = 0; i < 3; i++)
          OrderModel(
            id: 0,
            status: 'loading',
            totalPrice: '0',
            createdAt: '',
            productImage: null,
          ),
      ];
      return Scaffold(
        backgroundColor: AppColors.white,
        body: Skeletonizer(
          enabled: true,
          effect: ShimmerEffect(
            baseColor: Colors.grey.shade300.withOpacity(0.3),
            highlightColor: Colors.grey.shade100.withOpacity(0.1),
            duration: const Duration(milliseconds: 1200),
          ),
          child: ListView.builder(
            padding: EdgeInsets.all(20.w),
            itemCount: 3,
            itemBuilder: (_, i) => OrderCard(order: placeholders[i]),
          ),
        ),
      );
    }

    if (_error != null && _orders.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error!, textAlign: TextAlign.center),
              Gap(16.h),
              TextButton(
                onPressed: _loadOrders,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_orders.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.white,
        body: EmptyOrdersView(onHomeTap: widget.onHomeTap),
      );
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: RefreshIndicator(
          color: AppColors.white,
          backgroundColor: AppColors.primary,
          onRefresh: _refreshOrders,
          child: ListView.builder(
            padding: EdgeInsets.all(20.w),
            itemCount: _orders.length,
            itemBuilder: (context, index) {
              final order = _orders[index];
              return OrderCard(
                order: order,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Order #${order.id} details'),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
