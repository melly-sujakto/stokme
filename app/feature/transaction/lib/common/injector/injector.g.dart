// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configureBloc() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => SaleBloc(c<SaleUsecase>()));
    container.registerFactory((c) => PrintBloc());
  }

  @override
  void _configureUsecase() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => SaleUsecase(
        firebaseLibrary: c<FirebaseLibrary>(),
        sharedPreferencesWrapper: c<SharedPreferencesWrapper>()));
  }
}
