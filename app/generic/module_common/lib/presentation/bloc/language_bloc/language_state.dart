part of 'language_bloc.dart';

@immutable
abstract class LanguageState {
  final Locale locale;
  final Map<String, String> translations;

  const LanguageState(this.locale, this.translations);

  String localeAsEnumValue() => enumValueFromLocale(locale);

  static String enumValueFromLocale(Locale locale) =>
      Languages.values
          .firstWhereOrNull((element) => element.code == locale.languageCode)
          ?.value ??
      Languages.en.value;

  static Locale localeFromEnumValue(String value) {
    final code = Languages.values
            .firstWhereOrNull((element) => element.value == value)
            ?.code ??
        Languages.en.code;
    return Locale(code);
  }
}

class LanguageInitial extends LanguageState {
  LanguageInitial() : super(Locale(Languages.en.code), {});
}

class LanguageLoadedState extends LanguageState {
  const LanguageLoadedState(
    Locale locale,
    Map<String, String> translations,
  ) : super(locale, translations);
}
