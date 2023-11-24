// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:ui_kit/common/constants/layout_dimen.dart';
// import 'package:ui_kit/theme/colors.dart';
// import 'package:ui_kit/utils/screen_utils.dart';

// abstract class TextStyles {
//   static final _defaultTextStyle = GoogleFonts.nunito().w600;
//   static final _robotoTextStyle = GoogleFonts.roboto();
//   static final _openSansTextStyle = GoogleFonts.openSans();
//   static const _appFont = TextStyle(
//     fontFamily: 'Hellix',
//     package: 'ui_kit',
//   );

//   static final TextStyle noNameWelcome =
//       _defaultTextStyle.gray.setFontSize(LayoutDimen.dimen_15);

//   static final TextStyle noNameCheckbox = _defaultTextStyle.primaryDarkBlue
//       .setColorOpacity(LayoutDimen.dimen_0_75)
//       .setFontSize(LayoutDimen.dimen_13.sp);

//   static final TextStyle noNameRadioGroupExpand = _defaultTextStyle
//       .primaryDarkBlue.w800
//       .setFontSize(LayoutDimen.dimen_15.sp);

//   static TextStyle noNameSliderLabel = _defaultTextStyle.primaryDarkBlue.w400
//       .setFontSize(LayoutDimen.dimen_18.sp);

//   static TextStyle noNameHighlightedValue = _defaultTextStyle
//       .primaryDarkBlue.w700
//       .setFontSize(LayoutDimen.dimen_18.sp);

//   static TextStyle noNameHint = _defaultTextStyle.primaryDarkBlue.w600
//       .setFontSize(LayoutDimen.dimen_11.sp);

//   static TextStyle noNameSecondaryActionButton =
//       _defaultTextStyle.white.w700.setFontSize(LayoutDimen.dimen_12.sp);

//   static TextStyle noNameTabBarItem =
//       _defaultTextStyle.w700.setFontSize(LayoutDimen.dimen_15.sp);

//   static TextStyle noNameOnbCongratsTitle =
//       _defaultTextStyle.w700.setFontSize(LayoutDimen.dimen_20.sp);

//   static final TextStyle h2 = _defaultTextStyle.primaryDarkBlue.w800
//       .setFontSize(LayoutDimen.dimen_28.sp);

//   static final TextStyle h2Bold = h2.bold;

//   static final TextStyle h3 = _defaultTextStyle.primaryDarkBlue.w700
//       .setFontSize(LayoutDimen.dimen_22.sp);

//   static final TextStyle h4 = _defaultTextStyle.primaryDarkBlue.w700
//       .setFontSize(LayoutDimen.dimen_20.sp);

//   static final TextStyle body1 = _defaultTextStyle.primaryDarkBlue.w600
//       .setFontSize(LayoutDimen.dimen_15.sp);

//   static final TextStyle bodyText1 = _defaultTextStyle.copyWith(
//     fontSize: LayoutDimen.dimen_14.sp,
//     fontWeight: FontWeight.w600,
//     color: CustomColors.textFormHint,
//   );

//   static TextStyle body2 = _defaultTextStyle.primaryDarkBlue.w600
//       .setFontSize(LayoutDimen.dimen_13.sp);

//   static final TextStyle caption1 = _defaultTextStyle.primaryDarkBlue.w600
//       .setFontSize(LayoutDimen.dimen_13.sp);

//   static TextStyle caption2 =
//       _defaultTextStyle.gray.w600.setFontSize(LayoutDimen.dimen_11.sp);

//   static final TextStyle subtitle = _defaultTextStyle.primaryDarkBlue.w700
//       .setFontSize(LayoutDimen.dimen_17.sp);

//   static final TextStyle cardTitle = _defaultTextStyle.primaryDarkBlue.w600
//       .setFontSize(LayoutDimen.dimen_13.sp);

//   static final TextStyle cardSubtitle =
//       cardTitle.gray.setFontSize(LayoutDimen.dimen_11.sp);

//   static final TextStyle amountInCard =
//       cardTitle.setFontSize(LayoutDimen.dimen_15.sp);

//   static final TextStyle appBarTitle = _defaultTextStyle.primaryDarkBlue.w800
//       .setFontSize(LayoutDimen.dimen_17.sp);

//   static final TextStyle textInput = _defaultTextStyle.primaryDarkBlue.w600
//       .setFontSize(LayoutDimen.dimen_15.sp);

//   static final TextStyle prefixTexInput = textInput.gray;

//   static final TextStyle elevatedButton =
//       _defaultTextStyle.grayLight.w700.setFontSize(LayoutDimen.dimen_15.sp);

//   static final TextStyle textButtonStyle =
//       _defaultTextStyle.grayLight.w700.setFontSize(LayoutDimen.dimen_12.sp);

//   static final TextStyle cardNumber = _defaultTextStyle.primaryDarkBlue.w600
//       .setFontSize(LayoutDimen.dimen_18.sp);

//   static final TextStyle tabBarRoboto =
//       _robotoTextStyle.blackTabBar.w500.setFontSize(LayoutDimen.dimen_14.sp);

//   static final TextStyle priceOpenSans =
//       _openSansTextStyle.blackTabBar.w700.setFontSize(LayoutDimen.dimen_26.sp);

//   static final TextStyle roboto12 =
//       _robotoTextStyle.gray.w400.setFontSize(LayoutDimen.dimen_12.sp);

//   static final TextStyle openSans14 =
//       _openSansTextStyle.blackTabBar.w400.setFontSize(LayoutDimen.dimen_14.sp);

//   static final TextStyle roboto14 =
//       _robotoTextStyle.blackTabBar.w500.setFontSize(LayoutDimen.dimen_14.sp);

//   static final TextStyle nunitoPrimaryDark =
//       _defaultTextStyle.w600.primaryDark.w600;

//   static final TextStyle nunitoPrimaryDarkBlue =
//       _defaultTextStyle.w600.primaryDarkBlue;

//   static final TextStyle nunitoTitle = _defaultTextStyle.primaryDarkBlue.w600
//       .setFontSize(LayoutDimen.dimen_15.sp);

//   static final TextStyle noNameBlack = _defaultTextStyle.w600.black.setFontSize(
//     LayoutDimen.dimen_36.sp,
//   );

//   static final TextStyle appHeadlineLarge = _appFont.w600.setFontSize(
//     LayoutDimen.dimen_48.sp,
//     height: LayoutDimen.dimen_1_16,
//   );
//   static final TextStyle appHeadlineMedium = _appFont.w600.setFontSize(
//     LayoutDimen.dimen_34.sp,
//     height: LayoutDimen.dimen_1_17,
//   );
//   static final TextStyle appHeadlineSmall = _appFont.w600.setFontSize(
//     LayoutDimen.dimen_26.sp,
//     height: LayoutDimen.dimen_1_23,
//   );

//   static final TextStyle appTitleLarge = _appFont.w600.setFontSize(
//     LayoutDimen.dimen_20.sp,
//     height: LayoutDimen.dimen_1_2,
//   );
//   static final TextStyle appTitleMedium = _appFont.w600.setFontSize(
//     LayoutDimen.dimen_15.sp,
//     height: LayoutDimen.dimen_1_33,
//   );
//   static final TextStyle appTitleSmall = _appFont.w600.setFontSize(
//     LayoutDimen.dimen_13.sp,
//     height: LayoutDimen.dimen_1_15,
//   );

//   static final TextStyle appBodyLarge = _appFont.w500.setFontSize(
//     LayoutDimen.dimen_15.sp,
//     height: LayoutDimen.dimen_1_6,
//   );
//   static final TextStyle appBodyMedium = _appFont.w500.setFontSize(
//     LayoutDimen.dimen_13.sp,
//     height: LayoutDimen.dimen_1_53,
//   );
//   static final TextStyle appBodySmall = _appFont.w500.setFontSize(
//     LayoutDimen.dimen_11.sp,
//     height: LayoutDimen.dimen_1_45,
//   );

//   static final TextStyle appButtonLarge = _appFont.w700.setFontSize(
//     LayoutDimen.dimen_15.sp,
//     height: LayoutDimen.dimen_1_6,
//   );
//   static final TextStyle appButtonSmall = _appFont.w700.setFontSize(
//     LayoutDimen.dimen_13.sp,
//     height: LayoutDimen.dimen_1_23,
//   );

//   static final TextStyle appOverline = _appFont.w500.setFontSize(
//     LayoutDimen.dimen_13.sp,
//     height: LayoutDimen.dimen_1_23,
//     letterSpacing: LayoutDimen.dimen_1.sp,
//   );
// }

// extension TextStyleExt on TextStyle {
//   TextStyle setColor(Color color) => copyWith(color: color);

//   TextStyle get black => setColor(CustomColors.black);

//   TextStyle get blackTabBar => setColor(CustomColors.blackTabBar);

//   TextStyle get gray => setColor(CustomColors.gray);

//   TextStyle get grayLight => setColor(CustomColors.grayLight);

//   TextStyle get primaryDark => setColor(CustomColors.primaryDark);

//   TextStyle get primaryDarkBlue => setColor(CustomColors.primaryDarkBlue);

//   TextStyle get white => setColor(CustomColors.white);

//   TextStyle setColorOpacity(double opacity) =>
//       copyWith(color: color!.withOpacity(opacity));

//   TextStyle setWeight(FontWeight fontWeight) =>
//       copyWith(fontWeight: fontWeight);

//   TextStyle get bold => setWeight(FontWeight.bold);

//   TextStyle get w400 => setWeight(FontWeight.w400);

//   TextStyle get w500 => setWeight(FontWeight.w500);

//   TextStyle get w600 => setWeight(FontWeight.w600);

//   TextStyle get w700 => setWeight(FontWeight.w700);

//   TextStyle get w800 => setWeight(FontWeight.w800);

//   TextStyle setFontSize(
//     double fontSize, {
//     double? height,
//     double? letterSpacing,
//   }) =>
//       copyWith(
//         fontSize: fontSize,
//         height: height,
//         letterSpacing: letterSpacing,
//       );

//   TextStyle setOverflow(TextOverflow? overflow) => copyWith(overflow: overflow);

//   TextStyle get clip => setOverflow(TextOverflow.clip);

//   TextStyle get ellipsis => setOverflow(TextOverflow.ellipsis);

//   TextStyle get fade => setOverflow(TextOverflow.fade);

//   TextStyle get visible => setOverflow(TextOverflow.visible);
// }
