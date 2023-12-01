import 'dart:async';

import 'package:extensions/iterable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:module_common/common/enum/languages.dart';
import 'package:module_common/domain/usecase/language_usecase.dart';
import 'package:module_common/i18n/language/en.dart' as en;
import 'package:module_common/i18n/language/id.dart' as id;
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends BaseBloc<LanguageEvent, LanguageState> {
  final LanguageUsecase _languageUsecase;

  LanguageBloc(this._languageUsecase) : super(LanguageInitial()) {
    on<LanguageInitialLoad>((event, emit) async {
      final Locale locale = await _loadSavedLocale();
      await _handleLoadLanguage(locale, emit);
    });
    on<ChangeLocale>((event, emit) async {
      await _handleLoadLanguage(event.locale, emit);
    });
  }

  Future<Locale> _loadSavedLocale() async {
    return Locale(await _languageUsecase.getLanguage());
  }

  Future<void> _handleLoadLanguage(
    Locale locale,
    Emitter<LanguageState> emit,
  ) async {
    final Map<String, dynamic> translations = {};
    if (locale.languageCode == Languages.id.code) {
      translations.addAll(id.translations);
    } else {
      translations.addAll(en.translations);
    }

    unawaited(_languageUsecase.saveLanguageToLocal(locale.languageCode));

    emit(
      LanguageLoadedState(
        locale,
        translations.map((k, v) => MapEntry(k, '$v')),
      ),
    );
  }
}
