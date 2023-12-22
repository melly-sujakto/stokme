import 'package:feature_transaction/domain/usecase/sale_usecase.dart';
import 'package:feature_transaction/presentation/bloc/print_bloc.dart';
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

  @Dependencies.dependsOn(SaleBloc, [SaleUsecase])
  @Register.factory(SaleBloc)
  @Register.factory(PrintBloc)
  void _configureBloc();

  @Dependencies.dependsOn(
    SaleUsecase,
    [FirebaseLibrary, SharedPreferencesWrapper],
  )
  @Register.factory(SaleUsecase)
  void _configureUsecase();
}
