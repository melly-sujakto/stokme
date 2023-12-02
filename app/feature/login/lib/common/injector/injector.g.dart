// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configureBloc() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => LoginBloc(c<LoginUsecase>()));
  }

  @override
  void _configureUseCase() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => LoginUsecase(
        sharedPreferencesWrapper: c<SharedPreferencesWrapper>(),
        firebaseLibrary: c<FirebaseLibrary>()));
  }
}
