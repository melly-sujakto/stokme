import 'package:feature_dashboard/domain/navigation/usecase/home_usecase.dart';
import 'package:feature_dashboard/presentation/journey/home/bloc/home_bloc.dart';
import 'package:feature_dashboard/presentation/journey/more/bloc/more_bloc.dart';
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

  @Dependencies.dependsOn(MoreBloc, [FirebaseLibrary])
  @Dependencies.dependsOn(HomeBloc, [HomeUsecase])
  @Register.singleton(MoreBloc)
  @Register.singleton(HomeBloc)
  void _configureBloc();

  @Dependencies.dependsOn(HomeUsecase, [SharedPreferencesWrapper])
  @Register.singleton(HomeUsecase)
  void _configureUsecase();
}
