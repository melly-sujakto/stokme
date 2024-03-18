import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class PlainDialog {
  final Widget content;
  final double? height;
  final double? width;

  PlainDialog({
    required this.content,
    this.height,
    this.width,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: CustomColors.black.withOpacity(0.2),
      builder: (context) => Center(
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(
            LayoutDimen.dimen_10.w,
          ),
          child: Container(
            height: height ?? LayoutDimen.dimen_250.h,
            width: width ?? LayoutDimen.dimen_320.w,
            decoration: BoxDecoration(
              color: CustomColors.white,
              borderRadius: BorderRadius.circular(
                LayoutDimen.dimen_10.w,
              ),
            ),
            child: content,
          ),
        ),
      ),
    );
  }
}
