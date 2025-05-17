import 'package:evently/dm/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    super.key,
    required this.categories,
    required this.selectedTabBgColor,
    required this.unSelectedTabBgColor,
    required this.selectedTabContentColor,
    required this.unSelectedTabContentColor,
  });

  final List<CategoryDM> categories;
  final Color selectedTabBgColor;
  final Color unSelectedTabBgColor;
  final Color selectedTabContentColor;
  final Color unSelectedTabContentColor;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      child: TabBar(
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        indicatorColor: Colors.transparent,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        tabs:
            widget.categories
                .map(
                  (category) => buildTabComponent(
                    categoryDM: category,
                    isSelected:
                        widget.categories.indexOf(category) == currentIndex,
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget buildTabComponent({
    required CategoryDM categoryDM,
    required bool isSelected,
  }) {
    return Container(
      padding: REdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color:
            isSelected
                ? widget.selectedTabBgColor
                : widget.unSelectedTabBgColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color:
              isSelected
                  ? widget.selectedTabContentColor
                  : widget.unSelectedTabContentColor,
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          Icon(
            categoryDM.icon,
            color:
                isSelected
                    ? widget.selectedTabContentColor
                    : widget.unSelectedTabContentColor,
          ),
          SizedBox(width: 8.w),
          Text(
            categoryDM.name,
            style: TextStyle(
              color:
                  isSelected
                      ? widget.selectedTabContentColor
                      : widget.unSelectedTabContentColor,
            ),
          ),
        ],
      ),
    );
  }
}
