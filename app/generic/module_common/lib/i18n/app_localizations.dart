import 'dart:async';

import 'package:flutter/material.dart';
import 'package:module_common/common/enum/languages.dart';
import 'package:sprintf/sprintf.dart';

class SLocalizationsDelegate extends LocalizationsDelegate<S> {
  final Map<String, String> translations;
  final Locale locale;

  const SLocalizationsDelegate({
    required this.translations,
    required this.locale,
  });

  @override
  bool isSupported(Locale locale) =>
      Languages.values.map((e) => e.code).contains(locale.languageCode);

  @override
  Future<S> load(Locale locale) async => S(
        locale: locale,
        translations: translations,
      );

  @override
  bool shouldReload(SLocalizationsDelegate old) =>
      old.translations != translations;
}

class S {
  Locale locale;
  Map<String, String> translations;

  S({
    required this.locale,
    required this.translations,
  });

  factory S.of(BuildContext context) =>
      Localizations.of<S>(context, S) ??
      S(locale: Locale(Languages.en.code), translations: {});

  static bool isReady(BuildContext context) =>
      Localizations.of<S>(context, S) != null;

  String translate(
    String key, {
    List<dynamic> params = const [],
  }) {
    final translated = _getTranslation(key);
    if (translated.isEmpty) {
      return key;
    }
    return translationHelper(translated, params: params);
  }

  String translationHelper(
    String translation, {
    List<dynamic> params = const [],
  }) =>
      (() {
        try {
          return sprintf(translation, params);
        } catch (_) {
          return translation;
        }
      })()
          .replaceAll('\\n', '\n');

  String _getTranslation(String key) => translations[key] ?? '';
}
