import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/utils/screen_utils.dart';

enum SnackbarDialogType { success, failed }

class SnackbarDialog {
  void show({
    required BuildContext context,
    required String message,
    required SnackbarDialogType type,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        dismissDirection: DismissDirection.horizontal,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - LayoutDimen.dimen_100.h,
        ),
        padding: EdgeInsets.all(LayoutDimen.dimen_16.w),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        duration: const Duration(seconds: 3),
        content: Material(
          elevation: 2.0,
          borderRadius: BorderRadius.circular(LayoutDimen.dimen_30.w),
          child: Container(
            padding: EdgeInsets.all(LayoutDimen.dimen_12.w),
            width: ScreenUtil.screenWidth,
            decoration: BoxDecoration(
              color: CustomColors.whiteSmoke,
              borderRadius: BorderRadius.circular(LayoutDimen.dimen_30.w),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/${type == SnackbarDialogType.success ? 'success_icon.png' : 'failed_icon.png'}',
                  height: LayoutDimen.dimen_25.w,
                  width: LayoutDimen.dimen_25.w,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: LayoutDimen.dimen_16.w,
                ),
                Flexible(
                  child: Text(
                    message,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: CustomColors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
