import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class DummyCircleImage extends StatelessWidget {
  const DummyCircleImage({
    super.key,
    this.title = '',
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    late String logo;
    logo = title;
    if (title.isNotEmpty) {
      final titleSplitted = title.split(' ');
      if (titleSplitted.length == 1) {
        logo = titleSplitted.first[0].toUpperCase();
      }
      if (titleSplitted.length > 1) {
        logo = (titleSplitted.first[0] + titleSplitted.last[0]).toUpperCase();
      }
    }

    return Container(
      width: LayoutDimen.dimen_41.w,
      height: LayoutDimen.dimen_41.w,
      decoration: BoxDecoration(
        color: CustomColors.neutral.c90,
        borderRadius: BorderRadius.circular(LayoutDimen.dimen_50.w),
      ),
      child: Center(
        child: Text(
          logo,
          style: TextStyle(
            fontSize: LayoutDimen.dimen_13.minSp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
