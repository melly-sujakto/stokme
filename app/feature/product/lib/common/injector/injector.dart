import 'package:data_abstraction/repository/product_repository.dart';
import 'package:feature_product/domain/usecase/product_usecase.dart';
import 'package:feature_product/presentation/bloc/product_bloc.dart';
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

  @Register.factory(ProductBloc)
  void _configureBloc();

  @Register.factory(ProductUsecase)
  void _configureUsecase();
}
