import 'package:feature_supplier/domain/usecase/supplier_usecase.dart';
import 'package:feature_supplier/presentation/bloc/supplier_bloc.dart';
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

  @Register.factory(SupplierBloc)
  void _configureBloc();

  @Register.factory(SupplierUsecase)
  void _configureUsecase();
}
