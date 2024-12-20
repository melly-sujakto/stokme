// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configureBloc() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory((c) => ProfileBloc(c<DashboardUsecase>()))
      ..registerSingleton((c) => MoreBloc(c<DashboardUsecase>(), c<PrinterUtil>()))
      ..registerSingleton((c) => HomeBloc(c<DashboardUsecase>()));
  }

  @override
  void _configureUsecase() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => DashboardUsecase(
        sharedPreferencesWrapper: c<SharedPreferencesWrapper>(),
        firebaseLibrary: c<FirebaseLibrary>()));
  }
}
