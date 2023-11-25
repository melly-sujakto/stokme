import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class FlatButton extends StatelessWidget {
  const FlatButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: LayoutDimen.dimen_16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OutlinedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                CustomColors.secondary.c60,
              ),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            child: SizedBox(
              height: LayoutDimen.dimen_50.w,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: LayoutDimen.dimen_19.minSp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
