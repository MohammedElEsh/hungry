import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/styles.dart';
import '../../domain/entities/cart_item_entity.dart';

/// Display model for cart item (entity + optional UI fields from API).
class CartDisplayItem {
  final String itemId;
  final String name;
  final double price;
  final int quantity;
  /// Unit price formatted like API (e.g. "140.00").
  final String priceFormatted;
  final String? image;
  final List<String> toppingNames;
  final List<String> sideOptionNames;
  final double spicy;

  CartDisplayItem({
    required this.itemId,
    required this.name,
    required this.price,
    required this.quantity,
    String? priceFormatted,
    this.image,
    this.toppingNames = const [],
    this.sideOptionNames = const [],
    this.spicy = 0,
  }) : priceFormatted = priceFormatted ?? price.toStringAsFixed(2);

  factory CartDisplayItem.fromEntity(CartItemEntity e, {String? imageUrl}) {
    return CartDisplayItem(
      itemId: e.id,
      name: e.name,
      price: e.price,
      quantity: e.quantity,
      priceFormatted: e.priceFormatted,
      image: e.image ?? imageUrl,
      spicy: e.spicy,
      toppingNames: e.toppingNames,
      sideOptionNames: e.sideOptionNames,
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartDisplayItem item;
  final bool isRemoving;
  final VoidCallback onRemove;

  const CartItemWidget({
    super.key,
    required this.item,
    this.isRemoving = false,
    required this.onRemove,
  });

  String _getItemTotal(CartDisplayItem item) {
    return (item.price * item.quantity).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.itemId),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onRemove(),
      confirmDismiss: isRemoving ? (_) => Future.value(false) : null,
      background: _buildDeleteBackground(),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.05),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageWithBadge(),
                Gap(16.w),
                Expanded(child: _buildContent()),
              ],
            ),
          ),
          if (isRemoving) _buildRemovingOverlay(),
        ],
      ),
    );
  }

  Widget _buildRemovingOverlay() {
    return Positioned.fill(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: SizedBox(
            width: 36.w,
            height: 36.w,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
        ),
      ),
    );
  }

  // ===================== CONTENT =====================

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        Gap(6.h),
        _buildPriceBreakdown(),
        Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.spicy > 0) _buildSpicyLabel(),
              if (item.toppingNames.isNotEmpty) _buildToppingsRow(),
              if (item.sideOptionNames.isNotEmpty) _buildSideOptionsRow(),
            ],
          ),
        ),
        Gap(12.h),
        _buildFooter(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            item.name,
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 15.sp,
              color: AppColors.black,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Gap(8.w),
        _buildPriceTag(),
      ],
    );
  }

  Widget _buildPriceBreakdown() {
    return Text(
      '\$${item.priceFormatted} × ${item.quantity} = \$${_getItemTotal(item)}',
      style: AppTextStyles.bodySmall.copyWith(
        fontSize: 11.sp,
        color: AppColors.grey,
      ),
    );
  }

  Widget _buildSpicyLabel() {
    final pct = (item.spicy * 100).round();
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          Icon(Icons.local_fire_department_rounded, size: 12.sp, color: AppColors.secondary),
          Gap(4.w),
          Text(
            'Spicy: ${pct == 0 ? "Mild" : "$pct%"}',
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 11.sp,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToppingsRow() {
    final names = item.toppingNames.join(', ');
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.add_circle_outline_rounded, size: 12.sp, color: AppColors.grey),
          Gap(4.w),
          Expanded(
            child: Text(
              'Toppings: $names',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 11.sp,
                color: AppColors.grey,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideOptionsRow() {
    final names = item.sideOptionNames.join(', ');
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.restaurant_menu_rounded, size: 12.sp, color: AppColors.grey),
          Gap(4.w),
          Expanded(
            child: Text(
              'Sides: $names',
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 11.sp,
                color: AppColors.grey,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: onRemove,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: EdgeInsets.all(6.w),
            child: Icon(
              Icons.delete_outline_rounded,
              color: AppColors.error,
              size: 20.sp,
            ),
          ),
        ),
      ],
    );
  }

  // ===================== IMAGE =====================

  Widget _buildImageWithBadge() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: AppColors.grey.withOpacity(0.1),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.r),
            child: item.image != null
                ? Image.network(
                    item.image!,
                    width: 85.w,
                    height: 85.w,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) =>
                        _buildPlaceholder(85.w),
                  )
                : _buildPlaceholder(85.w),
          ),
        ),
        Positioned(
          top: -6.h,
          right: -6.w,
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              'x${item.quantity}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ===================== PRICE =====================

  Widget _buildPriceTag() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        '\$${_getItemTotal(item)}',
        style: AppTextStyles.titleSmall.copyWith(
          color: AppColors.secondary,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  // ===================== DELETE BG =====================

  Widget _buildDeleteBackground() {
    return Container(
      alignment: AlignmentDirectional.centerEnd,
      padding: EdgeInsets.only(right: 25.w),
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: const Icon(
        Icons.delete_outline_rounded,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  // ===================== PLACEHOLDER =====================

  Widget _buildPlaceholder(double size) {
    return Container(
      width: size,
      height: size,
      color: AppColors.grey.withOpacity(0.05),
      child: Icon(
        Icons.fastfood_rounded,
        color: AppColors.grey,
        size: 28.sp,
      ),
    );
  }
}