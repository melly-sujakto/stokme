part of 'language_bloc.dart';

abstract class LanguageEvent {}

class LanguageInitialLoad extends LanguageEvent {}

class ChangeLocale extends LanguageEvent {
  final Locale locale;

  ChangeLocale(this.locale);
}
