import 'package:feature_dashboard/domain/navigation/interaction_navigation.dart';
import 'package:feature_product/domain/navigation/interaction_navigation.dart';
import 'package:feature_stock/domain/navigation/interaction_navigation.dart';
import 'package:feature_transaction/domain/navigation/interaction_navigation.dart';
import 'package:library_injection/annotations.dart';
import 'package:library_injection/package/kiwi.dart';
import 'package:module_common/domain/usecase/language_usecase.dart';
import 'package:module_common/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:stokme/data/navigation/interaction_navigation_impl.dart';

part 'injector.g.dart';

// flutter packages pub run build_runner build
abstract class Injector {
  static void init() {
    KiwiContainer().clear();
    _$Injector()._configure();
  }

  static final T Function<T>([String name]) resolve = KiwiContainer().resolve;

  void _configure() {
    _configureBloc();
    _configureNavigation();
    _configureDependencies();
    _manualInjection();
  }

  void _manualInjection() {
    KiwiContainer()
      ..registerSingleton<DashboardInteractionNavigation>(
        (c) => c<InteractionNavigationImpl>(),
      )
      ..registerSingleton<ProductInteractionNavigation>(
        (c) => c<InteractionNavigationImpl>(),
      )
      ..registerSingleton<StockInteractionNavigation>(
        (c) => c<InteractionNavigationImpl>(),
      )
      ..registerSingleton<TransactionInteractionNavigation>(
        (c) => c<InteractionNavigationImpl>(),
      );
  }

  @Dependencies.dependsOn(
    LanguageBloc,
    [LanguageUsecase],
  )
  void _configureDependencies();

  @Register.singleton(LanguageBloc)
  void _configureBloc();

  @Register.singleton(InteractionNavigationImpl)
  void _configureNavigation();
}
