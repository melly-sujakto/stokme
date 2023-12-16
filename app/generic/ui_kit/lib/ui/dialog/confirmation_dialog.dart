import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/ui/button/flat_button.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class ConfirmationDialog {
  final String assetPath;
  final String descriptionText;
  final String cancelText;
  final String confirmText;
  final void Function()? onConfirmed;

  ConfirmationDialog({
    required this.assetPath,
    required this.descriptionText,
    required this.cancelText,
    required this.confirmText,
    this.onConfirmed,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: CustomColors.black.withOpacity(0.2),
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(),
          ),
          Center(
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(
                LayoutDimen.dimen_10.w,
              ),
              child: Container(
                height: LayoutDimen.dimen_230.h,
                width: LayoutDimen.dimen_320.w,
                padding: EdgeInsets.all(LayoutDimen.dimen_28.w),
                decoration: BoxDecoration(
                  color: CustomColors.white,
                  borderRadius: BorderRadius.circular(
                    LayoutDimen.dimen_10.w,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      assetPath,
                      height: LayoutDimen.dimen_60.w,
                      width: LayoutDimen.dimen_60.w,
                      fit: BoxFit.fitHeight,
                    ),
                    SizedBox(
                      height: LayoutDimen.dimen_8.h,
                    ),
                    Text(
                      descriptionText,
                      style: TextStyle(
                        fontSize: LayoutDimen.dimen_18.minSp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: LayoutDimen.dimen_8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton(
                          width: LayoutDimen.dimen_70.w,
                          title: cancelText,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          stretch: false,
                          color: CustomColors.secondary.c90,
                          margin: EdgeInsets.zero,
                        ),
                        FlatButton(
                          width: LayoutDimen.dimen_70.w,
                          title: confirmText,
                          onPressed: onConfirmed,
                          stretch: false,
                          margin: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
