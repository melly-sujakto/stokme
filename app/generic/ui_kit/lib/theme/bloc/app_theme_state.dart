part of 'app_theme_bloc.dart';

abstract class AppThemeState extends Equatable {
  @override
  List<Object?> get props => [runtimeType];
}

class AppThemeInitial extends AppThemeState {}

class AppThemeLoaded extends AppThemeState {
  AppThemeLoaded({
    required this.data,
  });

  final ThemeData data;

  @override
  List<Object?> get props => [...super.props, data];
}
