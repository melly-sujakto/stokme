import 'package:library_injection/package/kiwi.dart';
import 'package:ui_kit/theme/bloc/app_theme_bloc.dart';

part 'injector.g.dart';

abstract class Injector {
  static KiwiContainer container = KiwiContainer();

  static void init() {
    _$Injector()._configure();
  }

  static final T Function<T>([String name]) resolve = container.resolve;

  void _configure() {
    _configureBloc();
  }

  @Register.singleton(AppThemeBloc)
  void _configureBloc();
}
