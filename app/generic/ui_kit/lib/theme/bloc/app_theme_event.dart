part of 'app_theme_bloc.dart';

enum AppThemeMode {
  dark,
  light,
}

abstract class AppThemeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppThemeChange extends AppThemeEvent {
  AppThemeChange({required this.mode});

  final AppThemeMode mode;

  @override
  List<Object?> get props => [mode];
}
