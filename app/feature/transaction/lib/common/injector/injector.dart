import 'package:feature_transaction/domain/usecase/transaction_usecase.dart';
import 'package:feature_transaction/presentation/blocs/print_bloc/print_bloc.dart';
import 'package:feature_transaction/presentation/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:feature_transaction/presentation/journey/sale/bloc/sale_bloc.dart';
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

  @Dependencies.dependsOn(SaleBloc, [TransactionUsecase])
  @Register.factory(SaleBloc)
  @Register.factory(PrintBloc)
  @Dependencies.dependsOn(TransactionBloc, [TransactionUsecase])
  @Register.factory(TransactionBloc)
  void _configureBloc();

  @Dependencies.dependsOn(
    TransactionUsecase,
    [FirebaseLibrary, SharedPreferencesWrapper],
  )
  @Register.factory(TransactionUsecase)
  void _configureUsecase();
}
