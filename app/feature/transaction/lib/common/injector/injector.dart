import 'package:data_abstraction/repository/printer_repository.dart';
import 'package:data_abstraction/repository/product_repository.dart';
import 'package:feature_transaction/domain/usecase/transaction_usecase.dart';
import 'package:feature_transaction/presentation/blocs/print_bloc/print_bloc.dart';
import 'package:feature_transaction/presentation/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:feature_transaction/presentation/journey/sale/bloc/sale_bloc.dart';
import 'package:feature_transaction/presentation/journey/stock_in/bloc/stock_in_bloc.dart';
import 'package:feature_transaction/presentation/journey/transaction_list/bloc/transaction_list_bloc.dart';
import 'package:firebase_library/firebase_library.dart';
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

  @Register.factory(SaleBloc)
  @Register.factory(PrintBloc)
  @Register.factory(TransactionBloc)
  @Register.factory(StockInBloc)
  @Register.factory(TransactionListBloc)
  void _configureBloc();

  @Register.factory(TransactionUsecase)
  void _configureUsecase();
}
