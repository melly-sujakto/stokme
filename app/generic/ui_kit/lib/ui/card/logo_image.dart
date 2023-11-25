import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    // coba bikin flutter project tapi yg module
    return Container(
      width: LayoutDimen.dimen_200.w,
      height: LayoutDimen.dimen_175.h,
      color: CustomColors.primary.c50,
      child: Image.asset('assets/images/logo.png'),
    );
  }
}
