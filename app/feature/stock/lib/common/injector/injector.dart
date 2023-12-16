import 'package:feature_stock/presentation/bloc/stock_bloc.dart';
import 'package:library_injection/package/kiwi.dart';

part 'injector.g.dart';

abstract class Injector {
  static void init() {
    _$Injector()._configure();
  }

  static final T Function<T>([String name]) resolve = KiwiContainer().resolve;

  void _configure() {
    _configureBloc();
  }

  @Register.factory(StockBloc)
  void _configureBloc();
}
