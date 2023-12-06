import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class AppTabBar extends StatefulWidget {
  const AppTabBar({
    Key? key,
    required this.activeIndex,
    required this.items,
    this.onIndexChanged,
  }) : super(key: key);

  final int activeIndex;
  final List<AppTabBarItem> items;
  final void Function(int)? onIndexChanged;

  @override
  State<AppTabBar> createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar> {
  late int activeIndex;
  @override
  void initState() {
    super.initState();
    activeIndex = widget.activeIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(
        vertical: LayoutDimen.dimen_19.h,
      ),
      child: Row(
        children: widget.items.map(
          (item) {
            final index = widget.items.indexOf(item);
            return Row(
              children: [
                AppTabBarItemWidget(
                  onTap: () {
                    if (activeIndex != index) {
                      if (widget.onIndexChanged != null) {
                        widget.onIndexChanged!(index);
                      }
                      item.onTap();
                      setState(() {
                        activeIndex = index;
                      });
                    }
                  },
                  title: item.title,
                  isActive: activeIndex == index,
                ),
                SizedBox(
                  width: LayoutDimen.dimen_16.w,
                ),
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}

class AppTabBarItem {
  const AppTabBarItem({
    required this.onTap,
    required this.title,
  });

  final void Function() onTap;
  final String title;
}

class AppTabBarItemWidget extends StatelessWidget {
  const AppTabBarItemWidget({
    Key? key,
    required this.onTap,
    required this.title,
    required this.isActive,
  }) : super(key: key);

  final void Function() onTap;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutDimen.dimen_18.w,
          vertical: LayoutDimen.dimen_6.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isActive ? CustomColors.neutral.c90 : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: LayoutDimen.dimen_13.minSp,
            fontWeight: FontWeight.w600,
            color: isActive ? CustomColors.black : CustomColors.neutral.c50,
          ),
        ),
      ),
    );
  }
}
