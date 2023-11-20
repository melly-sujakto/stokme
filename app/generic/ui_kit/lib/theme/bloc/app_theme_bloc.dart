import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:ui_kit/theme/theme_data.dart';

part 'app_theme_event.dart';
part 'app_theme_state.dart';

class AppThemeBloc extends BaseBloc<AppThemeEvent, AppThemeState> {
  AppThemeBloc() : super(AppThemeInitial()) {
    on<AppThemeChange>(_onAppThemeChange);
  }

  late ThemeData _lastLoadedTheme;

  ThemeData get theme => _lastLoadedTheme;

  FutureOr<void> _onAppThemeChange(event, emit) {
    switch (event.mode) {
      // TODO(Melly): define theme data for dark theme
      case AppThemeMode.dark:
      case AppThemeMode.light:
      default:
        _lastLoadedTheme = CustomThemes.light;
        break;
    }
    emit(
      AppThemeLoaded(
        data: _lastLoadedTheme,
      ),
    );
  }
}
