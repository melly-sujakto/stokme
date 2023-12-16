import 'package:feature_stock/domain/usecase/stock_usecase.dart';
import 'package:feature_stock/presentation/bloc/stock_bloc.dart';
import 'package:firebase_library/firebase_library.dart';
import 'package:library_injection/annotations.dart';
import 'package:library_injection/package/kiwi.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

part 'injector.g.dart';

abstract class Injector {
  static void init() {
    _$Injector()._configure();
  }

  static final T Function<T>([String name]) resolve = KiwiContainer().resolve;

  void _configure() {
    _configureBloc();
    _configureUsecase();
  }

  @Dependencies.dependsOn(StockBloc, [StockUsecase])
  @Register.factory(StockBloc)
  void _configureBloc();

  @Dependencies.dependsOn(
    StockUsecase,
    [FirebaseLibrary, SharedPreferencesWrapper],
  )
  @Register.factory(StockUsecase)
  void _configureUsecase();
}
