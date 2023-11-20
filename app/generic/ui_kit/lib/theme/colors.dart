import 'package:flutter/material.dart';
import 'package:ui_kit/theme/app_color_palette.dart';

class CustomColors {
  static const Color transparent = Colors.transparent;
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color gray = Color(0xFF79838D);
  static const Color green = Color(0xFF1DC078);
  static const Color yellowMedium = Color(0xFFEFB54B);
  static const Color purple = Color(0xFF764BEF);

  static const Color grayLight = Color(0xFFEDF0F3);
  static const Color whiteSmoke = Color(0xFFF4F4F5);
  static const Color grayPale = Color(0xFFC4C4C4);
  static const Color primaryDarkBlue = Color(0xFF1F3140);
  static const Color primaryDark = Color(0xFF24272F);

  static const Color textButtonColor = Color(0xFF1F3140);
  static const Color checkboxColor = Color(0xFFC7CBCF);
  static const Color stepsInactive = Color(0x3379838D); // 20% alpha
  static const Color radioColor = Color(0xFFC7CBCF);

  static const Color error = Color(0xFFDD2222);
  static const Color textFormHint = Color(0xFF8E979F);
  static const Color blackTabBar = Color(0xFF000000);
  static const Color grayTabBar = Color(0xFFF5F7F9);

  static const Color shadow = Color(0x0A000000);

  /// UI Kit Color
  static const primary = AppColorPalette(
    c0: Color(0xFF000000),
    c10: Color(0xFF31020A),
    c20: Color(0xFF630315),
    c30: Color(0xFF94051F),
    c40: Color(0xFFC60629),
    c50: Color(0xFFF70834),
    c60: Color(0xFFF94868),
    c70: Color(0xFFFA6B85),
    c80: Color(0xFFFC9CAE),
    c90: Color(0xFFFDCED6),
    c95: Color(0xFFFEE6EB),
    c98: Color(0xFFFFF5F7),
    c100: Color(0xFFFFFFFF),
  );

  static const secondary = AppColorPalette(
    c0: Color(0xFF000000),
    c10: Color(0xFF12092A),
    c20: Color(0xFF251254),
    c30: Color(0xFF371C7D),
    c40: Color(0xFF4A25A7),
    c50: Color(0xFF5D2FD1),
    c60: Color(0xFF7D58DA),
    c70: Color(0xFF9D82E3),
    c80: Color(0xFFBEABED),
    c90: Color(0xFFDED5F6),
    c95: Color(0xFFEFEAFA),
    c98: Color(0xFFF8F7FD),
    c100: Color(0xFFFFFFFF),
  );

  static const tertiary = AppColorPalette(
    c0: Color(0xFF000000),
    c10: Color(0xFF1E072C),
    c20: Color(0xFF3D0F58),
    c30: Color(0xFF5B1683),
    c40: Color(0xFF791EAE),
    c50: Color(0xFF9825DA),
    c60: Color(0xFFAC51E1),
    c70: Color(0xFFC17CE9),
    c80: Color(0xFFD6A8F0),
    c90: Color(0xFFEAD3F8),
    c95: Color(0xFFF5E9FB),
    c98: Color(0xFFFBF6FE),
    c100: Color(0xFFFFFFFF),
  );

  static const neutral = AppColorPalette(
    c0: Color(0xFF000000),
    c10: Color(0xFF171A1C),
    c20: Color(0xFF2F3337),
    c30: Color(0xFF464D53),
    c40: Color(0xFF5E666E),
    c50: Color(0xFF79838D),
    c60: Color(0xFF9199A1),
    c70: Color(0xFFACB3B9),
    c80: Color(0xFFC8CCD0),
    c90: Color(0xFFE3E6E8),
    c95: Color(0xFFF1F2F3),
    c98: Color(0xFFF9FAFA),
    c100: Color(0xFFFFFFFF),
  );

  static const errorAccent = AppColorPalette(
    c0: Color(0xFF000000),
    c10: Color(0xFF300303),
    c20: Color(0xFF600606),
    c30: Color(0xFF910808),
    c40: Color(0xFFC10B0B),
    c50: Color(0xFFF10E0E),
    c60: Color(0xFFF44A4A),
    c70: Color(0xFFF76E6E),
    c80: Color(0xFFF99F9F),
    c90: Color(0xFFFCCFCF),
    c95: Color(0xFFFEE7E7),
    c98: Color(0xFFFEF5F5),
    c100: Color(0xFFFFFFFF),
  );

  static const successAccent = AppColorPalette(
    c0: Color(0xFF000000),
    c10: Color(0xFF072C1B),
    c20: Color(0xFF0E5837),
    c30: Color(0xFF158452),
    c40: Color(0xFF1DAF6D),
    c50: Color(0xFF22D081),
    c60: Color(0xFF50E2A0),
    c70: Color(0xFF7BEAB8),
    c80: Color(0xFFA7F1D0),
    c90: Color(0xFFD3F8E7),
    c95: Color(0xFFE9FBF3),
    c98: Color(0xFFF6FEFA),
    c100: Color(0xFFFFFFFF),
  );
}
