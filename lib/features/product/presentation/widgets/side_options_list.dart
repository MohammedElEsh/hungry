import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/models/side_options_model.dart';
import '../widgets/topping_card.dart';

class SideOptionsList extends StatelessWidget {
  final List<SideOptionsModel> items;
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
      return SizedBox(
        height: 50.h,
        child: const Center(
          child: CupertinoActivityIndicator(),
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
