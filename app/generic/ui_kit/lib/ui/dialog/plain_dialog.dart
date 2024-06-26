import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class PlainDialog {
  final Widget content;

  PlainDialog({
    required this.content,
  });

  void show(
    BuildContext context, {
    void Function(dynamic)? thenCallback,
  }) {
    showDialog(
      context: context,
      barrierColor: CustomColors.black.withOpacity(0.2),
      builder: (context) => Center(
        child: Padding(
          padding: EdgeInsets.all(LayoutDimen.dimen_32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(
                  LayoutDimen.dimen_10.w,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomColors.white,
                    borderRadius: BorderRadius.circular(
                      LayoutDimen.dimen_10.w,
                    ),
                  ),
                  child: content,
                ),
              ),
            ],
          ),
        ),
      ),
    ).then((value) {
      if (thenCallback != null) {
        thenCallback(value);
      }
    });
  }
}
