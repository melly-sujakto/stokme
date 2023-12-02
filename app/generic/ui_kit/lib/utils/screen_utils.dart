import 'dart:math';

import 'package:flutter/material.dart';

class ScreenUtil {
  static final ScreenUtil _instance = ScreenUtil._();
  static const int defaultWidth = 376;
  static const int defaultHeight = 812;
  static final Size defaultScreenSize =
      Size(defaultWidth.toDouble(), defaultHeight.toDouble());

  /// Size of the phone in UI Design , px
  late num uiWidthPx;
  late num uiHeightPx;
  late BuildContext rootContext;

  /// allowFontScaling Specifies whether fonts should scale
  /// to respect Text Size accessibility settings. The default is false.
  late bool allowFontScaling;

  static late MediaQueryData _mediaQueryData;

  factory ScreenUtil() {
    return _instance;
  }

  ScreenUtil._();

  ///
  /// This should be called once at app init
  /// * `width` the UI design width
  /// * `height` the UI design height
  ///
  static void init(
    BuildContext context, {
    num width = defaultWidth,
    num height = defaultHeight,
    bool allowFontScaling = false,
  }) {
    _instance;
    _instance.uiWidthPx = width;
    _instance.uiHeightPx = height;
    _instance.allowFontScaling = allowFontScaling;
    _instance.rootContext = context;

    _mediaQueryData = MediaQuery.of(context);
  }

  /// The number of font pixels for each logical pixel.
  static double get textScaleFactor => _mediaQueryData.textScaleFactor;

  /// The size of the media in logical pixels (e.g, the size of the screen).
  static double get pixelRatio => _mediaQueryData.devicePixelRatio;

  /// The horizontal extent of this size.
  static double get screenWidthDp => _mediaQueryData.size.width;

  ///The vertical extent of this size. dp
  static double get screenHeightDp => _mediaQueryData.size.height;

  /// The horizontal extent of this size. px
  static double get screenWidth => screenWidthDp * pixelRatio;

  /// The vertical extent of this size. px
  static double get screenHeight => screenHeightDp * pixelRatio;

  static double get heightToWidthRatio => screenHeight / screenWidth;

  /// The offset from the top
  static double get statusBarHeight => _mediaQueryData.padding.top;

  /// The offset from the bottom.
  static double get bottomBarHeight => _mediaQueryData.padding.bottom;

  /// The ratio of the actual dp to the design draft px
  double get scaleWidth => screenWidthDp / uiWidthPx;

  double get scaleHeight =>
      (screenHeightDp - statusBarHeight - bottomBarHeight) / uiHeightPx;

  double get scaleText => allowFontScaling ? scaleWidth : 1;

  double get minimumScale => min(scaleWidth, scaleHeight);

  /// Adapted to the device width of the UI Design.
  /// Height can also be adapted according to this to ensure no deformation ,
  /// if you want a square
  num setWidth(num width) => width * scaleWidth;

  /// Highly adaptable to the device according to UI Design
  /// It is recommended to use this method to
  /// achieve a high degree of adaptation
  /// when it is found that one screen in the UI design
  /// does not match the current style effect,
  ///  or if there is a difference in shape.
  num setHeight(num height) => height * scaleHeight;

  ///Font size adaptation method
  num setSp(num fontSize) => fontSize * scaleWidth;

  num setMinSp(num fontSize) => fontSize * minimumScale;
}

extension _ScreenUtilExt on num {
  num get h => ScreenUtil().setHeight(this);

  num get w => ScreenUtil().setWidth(this);

  num get sp => ScreenUtil().setSp(this);

  num get minSp => ScreenUtil().setMinSp(this);

  double get hAsDouble => h.toDouble();

  double get wAsDouble => w.toDouble();

  double get spAsDouble => sp.toDouble();

  double get minSpAsDouble => minSp.toDouble();
}

extension ScreenUtilDoubleExt on double {
  double get h => hAsDouble;

  double get w => wAsDouble;

  double get sp => spAsDouble;

  double get minSp => minSpAsDouble;
}
