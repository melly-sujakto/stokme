import 'package:feature_dashboard/domain/navigation/usecase/dashboard_usecase.dart';
import 'package:feature_dashboard/presentation/journey/home/bloc/home_bloc.dart';
import 'package:feature_dashboard/presentation/journey/more/bloc/more_bloc.dart';
import 'package:feature_dashboard/presentation/journey/profile/bloc/profile_bloc.dart';
import 'package:firebase_library/firebase_library.dart';
import 'package:library_injection/package/kiwi.dart';
import 'package:module_common/common/utils/printer_util.dart';
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

  @Register.factory(ProfileBloc)
  @Register.singleton(MoreBloc)
  @Register.singleton(HomeBloc)
  void _configureBloc();

  @Register.singleton(DashboardUsecase)
  void _configureUsecase();
}
