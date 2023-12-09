import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class AppBarWithTitleOnly extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarWithTitleOnly({super.key, required this.appBarTitle});
  final String appBarTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        appBarTitle,
        style: TextStyle(
          fontSize: LayoutDimen.dimen_19.minSp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0.h);
}
