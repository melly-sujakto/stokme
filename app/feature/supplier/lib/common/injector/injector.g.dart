// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configureBloc() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => SupplierBloc(c<SupplierUsecase>()));
  }

  @override
  void _configureUsecase() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => SupplierUsecase(
        firebaseLibrary: c<FirebaseLibrary>(),
        sharedPreferencesWrapper: c<SharedPreferencesWrapper>()));
  }
}
