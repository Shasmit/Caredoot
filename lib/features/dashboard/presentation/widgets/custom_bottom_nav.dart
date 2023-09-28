import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app_imports.dart';
import '../../../../ui/atoms/bounce_widget.dart';

class CustomBottomNav extends StatefulWidget {
  final ValueChanged<int> onChanged;
  const CustomBottomNav({
    Key? key,
    required this.selectedIndex,
    required this.onChanged,
  }) : super(key: key);

  final int selectedIndex;

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  @override
  Widget build(BuildContext context) {
    final list = [
      BottomNavItemDetails(
        title: "Home",
        svgPath: AppIcons.home,
      ),
      BottomNavItemDetails(
        title: "Bookings",
        svgPath: AppIcons.bookings,
      ),
      BottomNavItemDetails(
        title: "Profile",
        svgPath: AppIcons.profile,
      ),
      BottomNavItemDetails(
        title: "Cart",
        svgPath: AppIcons.bookings,
      ),
    ];

    return Container(
      height: 87.h,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey,
            blurRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            list.length,
            (index) {
              return BottomNavItem(
                item: list[index],
                onTap: () {
                  widget.onChanged(index);
                },
                isSelected: index == widget.selectedIndex,
              );
            },
          ),
        ),
      ),
    );
  }
}

class BottomNavItemDetails {
  final String title;
  final String svgPath;

  BottomNavItemDetails({
    required this.title,
    required this.svgPath,
  });
}

class BottomNavItem extends StatelessWidget {
  final BottomNavItemDetails item;
  final VoidCallback onTap;
  final bool isSelected;

  const BottomNavItem({
    Key? key,
    required this.item,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : AppColors.grey;
    return BouncingWidget(
      onPressed: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomSpacers.height2,
            SvgPicture.asset(item.svgPath, color: color, height: 24, width: 24),
            CustomSpacers.height2,
            Text(
              item.title,
              style: AppTextStyles.textStyleLato10w400
                  .copyWith(
                      color: isSelected ? AppColors.primary : AppColors.grey)
                  .copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
