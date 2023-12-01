import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class FlatButton extends StatelessWidget {
  const FlatButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.stretch = true,
    this.color,
    this.titleStyle,
    this.width,
    this.margin,
  }) : super(key: key);

  final String title;
  final bool stretch;
  final Color? color;
  final TextStyle? titleStyle;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null;
    return Padding(
      padding:
          margin ?? EdgeInsets.symmetric(horizontal: LayoutDimen.dimen_16.w),
      child: Column(
        crossAxisAlignment:
            stretch ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
        children: [
          OutlinedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                isDisabled
                    ? CustomColors.neutral.c80
                    : color ?? CustomColors.secondary.c60,
              ),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            child: SizedBox(
              height: LayoutDimen.dimen_50.w,
              width: width,
              child: Center(
                child: Text(
                  title,
                  style: titleStyle ??
                      TextStyle(
                        fontSize: LayoutDimen.dimen_19.minSp,
                        color: isDisabled
                            ? CustomColors.white
                            : CustomColors.black,
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
