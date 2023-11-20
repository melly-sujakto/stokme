import 'package:ui_kit/utils/screen_utils.dart';

extension SizeExtension on num {
  num get sw => ScreenUtil.screenWidthDp;
  num get sh => ScreenUtil.screenHeightDp;
  num get w => ScreenUtil().setWidth(this);
  num get h => ScreenUtil().setHeight(this);
  num get sp => ScreenUtil().setSp(this);
  num get minSp => ScreenUtil().setMinSp(this);
}

extension SizeExtensionDouble on double {
  double get sw => ScreenUtil.screenWidthDp;
  double get sh => ScreenUtil.screenHeightDp;
  double get w => ScreenUtil().setWidth(this).toDouble();
  double get h => ScreenUtil().setHeight(this).toDouble();
  double get sp => ScreenUtil().setSp(this).toDouble();
  double get minSp => ScreenUtil().setMinSp(this).toDouble();
}
