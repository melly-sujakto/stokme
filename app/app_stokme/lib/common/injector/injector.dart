import 'package:feature_dashboard/domain/navigation/interaction_navigation.dart';
import 'package:feature_product/domain/navigation/interaction_navigation.dart';
import 'package:feature_stock/domain/navigation/interaction_navigation.dart';
import 'package:feature_transaction/domain/navigation/interaction_navigation.dart';
import 'package:library_injection/package/kiwi.dart';
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
    _configureNavigation();
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

  @Register.singleton(InteractionNavigationImpl)
  void _configureNavigation();
}
