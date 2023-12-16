// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configureBloc() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => StockBloc(c<StockUsecase>()));
  }

  @override
  void _configureUsecase() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => StockUsecase(
        firebaseLibrary: c<FirebaseLibrary>(),
        sharedPreferencesWrapper: c<SharedPreferencesWrapper>()));
  }
}
