import 'package:flutter/material.dart';

import 'app_color_palette.dart';

class AppColorScheme extends ColorScheme {
  const AppColorScheme({
    required super.brightness,
    required super.primary,
    required super.onPrimary,
    required super.primaryContainer,
    required super.onPrimaryContainer,
    required super.secondary,
    required super.onSecondary,
    required super.secondaryContainer,
    required super.onSecondaryContainer,
    required super.tertiary,
    required super.onTertiary,
    required super.tertiaryContainer,
    required super.onTertiaryContainer,
    required super.error,
    required super.onError,
    required super.errorContainer,
    required super.onErrorContainer,
    required super.background,
    required super.onBackground,
    required super.surface,
    required super.onSurface,
    required super.outline,
    required this.successSurface,
    required this.onSuccessSurface,
    required this.successSurfaceContainer,
    required this.onSuccessSurfaceContainer,
    required this.appPrimary,
    required this.appSecondary,
    required this.appTertiary,
    required this.appNeutral,
    required this.appErrorAccent,
    required this.appSuccessAccent,
  });

  final AppColorPalette appPrimary;
  final AppColorPalette appSecondary;
  final AppColorPalette appTertiary;
  final AppColorPalette appNeutral;
  final AppColorPalette appErrorAccent;
  final AppColorPalette appSuccessAccent;

  final Color successSurface;
  final Color onSuccessSurface;
  final Color successSurfaceContainer;
  final Color onSuccessSurfaceContainer;
}
