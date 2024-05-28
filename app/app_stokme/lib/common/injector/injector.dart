import 'package:data_abstraction/repository/printer_repository.dart';
import 'package:data_abstraction/repository/product_repository.dart';
import 'package:feature_dashboard/domain/navigation/interaction_navigation.dart';
import 'package:feature_login/domain/navigation/interaction_navigation.dart';
import 'package:feature_product/domain/navigation/interaction_navigation.dart';
import 'package:feature_stock/domain/navigation/interaction_navigation.dart';
import 'package:feature_supplier/domain/navigation/interaction_navigation.dart';
import 'package:feature_transaction/domain/navigation/interaction_navigation.dart';
import 'package:firebase_library/firebase_library.dart';
import 'package:library_injection/package/kiwi.dart';
import 'package:module_common/common/utils/printer_util.dart';
import 'package:module_common/domain/usecase/language_usecase.dart';
import 'package:module_common/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';
import 'package:stokme/common/feature_flag_updater/feature_flag_updater.dart';
import 'package:stokme/common/feature_flag_updater/firebase_remote_config/firebase_remote_config_wrapper.dart';
import 'package:stokme/data/navigation/interaction_navigation_impl.dart';
import 'package:stokme/data/repository/printer_repository_impl.dart';
import 'package:stokme/data/repository/product_repository_impl.dart';

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
    _configureLibraries();
    _manualInjection();
    _configureCommon();
    _configureRepositories();
  }

  void _manualInjection() {
    KiwiContainer()
      ..registerSingleton<LoginInteractionNavigation>(
        (c) => c<InteractionNavigationImpl>(),
      )
      ..registerSingleton<DashboardInteractionNavigation>(
        (c) => c<InteractionNavigationImpl>(),
      )
      ..registerSingleton<ProductInteractionNavigation>(
        (c) => c<InteractionNavigationImpl>(),
      )
      ..registerSingleton<StockteractionNavigation>(
        (c) => c<InteractionNavigationImpl>(),
      )
      ..registerSingleton<SupplierInteractionNavigation>(
        (c) => c<InteractionNavigationImpl>(),
      )
      ..registerSingleton<TransactionInteractionNavigation>(
        (c) => c<InteractionNavigationImpl>(),
      );
  }

  @Register.singleton(LanguageBloc)
  void _configureBloc();

  @Register.singleton(InteractionNavigationImpl)
  void _configureNavigation();

  @Register.singleton(FirebaseLibrary)
  void _configureLibraries();

  @Register.singleton(FirebaseRemoteConfigWrapper)
  @Register.singleton(FeatureFlagUpdater)
  void _configureCommon();

  @Register.singleton(PrinterRepository, from: PrinterRepositoryImpl)
  @Register.singleton(ProductRepository, from: ProductRepositoryImpl)
  void _configureRepositories();
}
