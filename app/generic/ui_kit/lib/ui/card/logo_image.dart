import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: LayoutDimen.dimen_200.w,
      height: LayoutDimen.dimen_175.h,
      child: Image.asset('assets/images/logo.png'),
    );
  }
}
