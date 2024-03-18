import 'package:feature_login/domain/usecase/login_usecase.dart';
import 'package:feature_login/presentation/bloc/login_bloc.dart';
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
    _configureUseCase();
  }

  @Register.singleton(LoginBloc)
  void _configureBloc();

  @Register.singleton(LoginUsecase)
  void _configureUseCase();
}
