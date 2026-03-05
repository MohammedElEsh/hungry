import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/app_colors.dart' show AppColors;
import '../../domain/entities/order_entity.dart';
import 'order_status_badge.dart';

/// --- Main Redesigned Order Card ---
class OrderCard extends StatelessWidget {
  final OrderEntity order;
  final VoidCallback? onTap;

  const OrderCard({
    super.key,
    required this.order,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r), // Softer, modern corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image Container
                    _buildImageThumbnail(),
                    Gap(16.w),
                    
                    // Order Information
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order #${order.id}',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.black,
                                ),
                              ),
                              OrderStatusBadge(status: order.status),
                            ],
                          ),
                          Gap(4.h),
                          Row(
                            children: [
                              Icon(Icons.calendar_today_outlined, 
                                   size: 12.sp, color: Colors.grey),
                              Gap(4.w),
                              Text(
                                order.createdAt,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Divider(
                    color: Colors.grey.withOpacity(0.1),
                    thickness: 1,
                    height: 1,
                  ),
                ),

                // Bottom Section: Total and Action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Amount",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "\$${order.total.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    _buildViewButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageThumbnail() {
    return Container(
      width: 64.h,
      height: 64.h,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: (order.productImage != null && order.productImage!.isNotEmpty)
            ? Image.network(
                order.productImage!,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => _buildPlaceholderIcon(),
              )
            : _buildPlaceholderIcon(),
      ),
    );
  }

  Widget _buildPlaceholderIcon() {
    return Icon(Icons.shopping_bag_outlined, 
                color: AppColors.primary.withOpacity(0.5), size: 28.sp);
  }

  Widget _buildViewButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Text(
            "Details",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(4.w),
          Icon(Icons.arrow_forward_ios, size: 10.sp, color: Colors.white),
        ],
      ),
    );
  }
}