import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/app_color_scheme.dart';
import 'package:ui_kit/theme/bloc/app_theme_bloc.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/utils/screen_utils.dart';

abstract class CustomThemes {
  /// light theme
  static final light = ThemeData(
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      toolbarHeight: LayoutDimen.dimen_56.h,
      elevation: LayoutDimen.dimen_0,
      centerTitle: false,
      iconTheme: IconThemeData(
        size: LayoutDimen.dimen_24.w,
      ),
      actionsIconTheme: IconThemeData(
        size: LayoutDimen.dimen_24.w,
      ),
    ),
    cardTheme: CardTheme(
      color: CustomColors.neutral.c100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LayoutDimen.dimen_10.w),
      ),
      elevation: 0,
    ),
    // textTheme: TextTheme(
    //   headlineLarge: TextStyles.appHeadlineLarge,
    //   headlineMedium: TextStyles.appHeadlineMedium,
    //   headlineSmall: TextStyles.appHeadlineSmall,
    //   titleLarge: TextStyles.appTitleLarge,
    //   titleMedium: TextStyles.appTitleMedium,
    //   titleSmall: TextStyles.appTitleSmall,
    //   bodyLarge: TextStyles.appBodyLarge,
    //   bodyMedium: TextStyles.appBodyMedium,
    //   bodySmall: TextStyles.appBodySmall,
    //   // (TextTheme implementation): TextStyle get overline => labelLarge
    //   labelLarge: TextStyles.appButtonLarge,
    //   // We use label medium for button small
    //   labelMedium: TextStyles.appButtonSmall,
    //   // (TextTheme implementation): TextStyle get overline => labelSmall
    //   labelSmall: TextStyles.appOverline,
    // ),
    textTheme: GoogleFonts.interTextTheme(),
    colorScheme: AppColorScheme(
      brightness: Brightness.light,
      primary: CustomColors.primary.c0,
      onPrimary: CustomColors.primary.c100,
      primaryContainer: CustomColors.primary.c98,
      onPrimaryContainer: CustomColors.primary.c60,
      secondary: CustomColors.secondary.c50,
      onSecondary: CustomColors.secondary.c100,
      secondaryContainer: CustomColors.secondary.c98,
      onSecondaryContainer: CustomColors.secondary.c50,
      tertiary: CustomColors.tertiary.c20,
      onTertiary: CustomColors.tertiary.c100,
      tertiaryContainer: CustomColors.tertiary.c98,
      onTertiaryContainer: CustomColors.tertiary.c20,
      surface: CustomColors.white,
      onSurface: CustomColors.black,
      error: CustomColors.errorAccent.c60,
      onError: CustomColors.errorAccent.c100,
      errorContainer: CustomColors.errorAccent.c98,
      onErrorContainer: CustomColors.errorAccent.c60,
      outline: CustomColors.neutral.c95,

      /// Below values are randomly choosen,
      /// since its not defiend on figma
      background: CustomColors.neutral.c98,
      onBackground: CustomColors.neutral.c10,

      /// Custom Implementation
      successSurface: CustomColors.successAccent.c100,
      onSuccessSurface: CustomColors.successAccent.c40,
      successSurfaceContainer: CustomColors.successAccent.c100,
      onSuccessSurfaceContainer: CustomColors.successAccent.c40,

      appPrimary: CustomColors.primary,
      appSecondary: CustomColors.secondary,
      appTertiary: CustomColors.tertiary,
      appNeutral: CustomColors.neutral,
      appErrorAccent: CustomColors.errorAccent,
      appSuccessAccent: CustomColors.successAccent,
    ),
    fontFamily: 'Hellix',
    useMaterial3: true,
  );
}

extension ThemeDataExt on ThemeData {
  /// Get color AppColorScheme
  /// If the color scheme type not AppColorScheme
  /// Exception will be thrown
  AppColorScheme get appColorScheme {
    if (colorScheme is AppColorScheme) {
      return colorScheme as AppColorScheme;
    }
    throw Exception('There is no app color scheme on this theme data');
  }
}

abstract class AppTheme {
  static ThemeData of(BuildContext context) {
    return context.read<AppThemeBloc>().theme;
  }
}
