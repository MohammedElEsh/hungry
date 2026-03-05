import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/topping_entity.dart';
import 'topping_card.dart';

class ToppingsList extends StatelessWidget {
  final List<ToppingEntity> toppings;
  final Set<int> selectedIds;
  final ValueChanged<int> onToppingTapped;

  const ToppingsList({
    super.key,
    required this.toppings,
    required this.selectedIds,
    required this.onToppingTapped,
  });

  @override
  Widget build(BuildContext context) {
    if (toppings.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Text(
          'No toppings available',
          style: TextStyle(fontSize: 14.sp, color: AppColors.grey),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(
            toppings.length,
            (index) => Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: ToppingCard(
                text: toppings[index].name,
                imageUrl: toppings[index].image,
                buttonColor: AppColors.error,
                isSelected: selectedIds.contains(toppings[index].id),
                onTap: () => onToppingTapped(toppings[index].id),
              ),
            ),
          ),
          SizedBox(width: 15.w),
        ],
      ),
    );
  }
}
