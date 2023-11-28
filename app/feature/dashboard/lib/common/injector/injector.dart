import 'package:feature_dashboard/presentation/journey/more/bloc/more_bloc.dart';
import 'package:firebase_library/firebase_library.dart';
import 'package:library_injection/annotations.dart';
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

  @Dependencies.dependsOn(MoreBloc, [FirebaseLibrary])
  @Register.singleton(MoreBloc)
  void _configureBloc();
}
