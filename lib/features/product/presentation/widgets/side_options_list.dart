import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/side_option_entity.dart';
import 'topping_card.dart';

class SideOptionsList extends StatelessWidget {
  final List<SideOptionEntity> items;
  final Set<int> selectedIds;
  final ValueChanged<int> onSideOptionTapped;

  const SideOptionsList({
    super.key,
    required this.items,
    required this.selectedIds,
    required this.onSideOptionTapped,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Text(
          'No side options available',
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
            items.length,
            (index) => Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: ToppingCard(
                text: items[index].name,
                imageUrl: items[index].image,
                buttonColor: AppColors.success,
                isSelected: selectedIds.contains(items[index].id),
                onTap: () => onSideOptionTapped(items[index].id),
              ),
            ),
          ),
          SizedBox(width: 15.w),
        ],
      ),
    );
  }
}
