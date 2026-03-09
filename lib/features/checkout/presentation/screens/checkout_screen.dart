import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/app_router.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../orders/domain/usecases/create_order_usecase.dart';
import '../../../../core/notifications/notification_service.dart' as notifications;
import '../../../profile/domain/entities/profile_entity.dart';
import '../../../profile/domain/usecases/get_profile_usecase.dart';
import '../../../../core/utils/styles.dart';
import '../widgets/order_summary_section.dart';
import '../widgets/payment_action_section.dart';
import '../widgets/payment_methods_section.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  AuthRepository get _auth => sl<AuthRepository>();
  CreateOrderUseCase get _createOrderUseCase => sl<CreateOrderUseCase>();
  GetProfileUseCase get _getProfileUseCase => sl<GetProfileUseCase>();
  ProfileEntity? _profile;
  bool _isLoading = true;
  bool _isPaying = false;
  String? _error;

  Future<void> _loadProfile() async {
    if (!_auth.isGuest) {
      final result = await _getProfileUseCase();
      if (mounted) {
        result.when(
          success: (p) => setState(() => _profile = p),
          onFailure: (_) => setState(() => _profile = null),
        );
      }
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _handlePayNow(
    BuildContext context,
    CartCubit cartCubit,
    List<CartItemEntity> items,
  ) async {
    if (_isPaying) return;
    if (_auth.isGuest) {
      showErrorBanner(context, 'sign_in_to_place_order'.tr());
      return;
    }
    if (items.isEmpty) {
      showErrorBanner(context, 'cart_empty'.tr());
      return;
    }
    setState(() => _isPaying = true);
    final result = await _createOrderUseCase(items);
    if (!mounted) return;
    setState(() => _isPaying = false);
    result.when(
      success: (_) async {
        cartCubit.clearCart();
        await sl<notifications.AppNotificationService>().showOrderPlaced();
        if (!context.mounted) return;
        showSuccessBanner(context, 'order_placed_success'.tr());
        if (!context.mounted) return;
        context.go(AppRouter.kHomeView);
      },
      onFailure: (f) {
        if (mounted) setState(() => _isPaying = false);
        if (context.mounted) {
          showErrorBanner(context, '${'order_failed'.tr()}: ${f.message}');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null && !_isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error!, textAlign: TextAlign.center),
              Gap(16.h),
              TextButton(
                onPressed: () {
                  setState(() => _error = null);
                  _loadProfile();
                },
                child: Text('retry'.tr()),
              ),
            ],
          ),
        ),
      );
    }
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cartState) {
        final items = cartState is CartLoaded ? cartState.items : <CartItemEntity>[];
        // Use API total when present; otherwise fall back to sum of items.
        final subtotal = cartState is CartLoaded && cartState.totalPriceFromApi != null && cartState.totalPriceFromApi!.isNotEmpty
            ? (double.tryParse(cartState.totalPriceFromApi!.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0)
            : items.fold(0.0, (s, i) => s + (i.price * i.quantity));

        return Scaffold(
          body: Skeletonizer(
            enabled: _isLoading,
            effect: ShimmerEffect(
              baseColor: Colors.grey.shade300.withOpacity(0.3),
              highlightColor: Colors.grey.shade100.withOpacity(0.1),
              duration: const Duration(milliseconds: 1200),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(80.h),
                  Text("order_summary".tr(), style: AppTextStyles.bodyBrown),
                  OrderSummarySection(subtotal: subtotal),
                  Gap(60.h),
                  Text("payment_methods".tr(), style: AppTextStyles.bodyBrown),
                  Gap(20.h),
                  PaymentMethods(savedCardDisplay: _profile?.visa),
                  Gap(115.h),
                  PaymentActionSection(
                    totalPrice: subtotal.toStringAsFixed(2),
                    onPayNow: () => _handlePayNow(
                      context,
                      context.read<CartCubit>(),
                      items,
                    ),
                    isLoading: _isPaying,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
