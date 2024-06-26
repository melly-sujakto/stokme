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
      ..registerFactory((c) => SaleBloc(c<TransactionUsecase>()))
      ..registerFactory((c) => PrintBloc(c<TransactionUsecase>(),
          c<SharedPreferencesWrapper>(), c<PrinterUtil>()))
      ..registerFactory((c) => TransactionBloc(c<TransactionUsecase>()))
      ..registerFactory((c) => StockInBloc(c<TransactionUsecase>()))
      ..registerFactory((c) => TransactionListBloc(c<TransactionUsecase>()));
  }

  @override
  void _configureUsecase() {
    final KiwiContainer container = KiwiContainer();
    container.registerFactory((c) => TransactionUsecase(
        firebaseLibrary: c<FirebaseLibrary>(),
        sharedPreferencesWrapper: c<SharedPreferencesWrapper>(),
        productRepository: c<ProductRepository>()));
  }
}
