// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configureDependencies() {}
  @override
  void _configureBloc() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => LanguageBloc(c<LanguageUsecase>()));
  }

  @override
  void _configureNavigation() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => InteractionNavigationImpl());
  }
}
