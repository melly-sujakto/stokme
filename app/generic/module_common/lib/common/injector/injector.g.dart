// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configureBloc() {}
  @override
  void _configureUseCase() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton(
        (c) => LanguageUsecase(c<SharedPreferencesWrapper>()));
  }

  @override
  void _configureUtils() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => PrinterUtil());
  }

  @override
  void _configureLocalDatasource() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => SharedPreferencesWrapper());
  }
}
