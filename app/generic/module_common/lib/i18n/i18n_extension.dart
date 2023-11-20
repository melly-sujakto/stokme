import 'package:flutter/material.dart';
import 'package:module_common/i18n/app_localizations.dart';

extension I18nExtensions on String {
  String i18n(BuildContext context, {List<dynamic> params = const []}) =>
      S.of(context).translate(this, params: params);
}
