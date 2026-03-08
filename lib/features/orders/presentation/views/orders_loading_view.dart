import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/skeleton_loading.dart';
import '../../domain/entities/order_entity.dart';
import '../widgets/order_card.dart';

/// Skeleton view shown while orders are loading.
class OrdersLoadingView extends StatelessWidget {
  const OrdersLoadingView({super.key});

  static List<OrderEntity> get _placeholders => [
        for (int i = 0; i < 4; i++)
          const OrderEntity(
            id: '0',
            status: 'loading',
            total: 0,
            createdAt: '',
          ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: skeletonize(
        enabled: true,
        child: ListView.builder(
          padding: EdgeInsets.all(20.w),
          itemCount: 4,
          itemBuilder: (_, i) => OrderCard(order: _placeholders[i]),
        ),
      ),
    );
  }
}
