import 'package:feature_dashboard/common/injector/injector.dart'
    as dashboard_injector;
import 'package:feature_login/common/injector/injector.dart' as login_injector;
import 'package:feature_product/common/injector/injector.dart'
    as product_injector;
import 'package:feature_stock/common/injector/injector.dart' as stock_injector;
import 'package:feature_transaction/common/injector/injector.dart'
    as transaction_injector;
import 'package:firebase_library/firebase_library.dart';
import 'package:flutter/material.dart';
import 'package:module_common/common/injector/injector.dart'
    as module_common_injector;
import 'package:module_common/presentation/bloc/language_bloc/language_bloc.dart';
import 'package:stokme/common/feature_flag_updater/feature_flag_updater.dart';
import 'package:stokme/common/injector/injector.dart' as app_injector;
import 'package:stokme/firebase_options.dart';
import 'package:stokme/presentation/app.dart';
import 'package:ui_kit/common/injector/injector.dart' as ui_kit_injector;
import 'package:ui_kit/theme/bloc/app_theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _configureInjector();
  await app_injector.Injector.resolve<FirebaseLibrary>().init(
    DefaultFirebaseOptions.currentPlatform,
  );

  final languageBloc = app_injector.Injector.resolve<LanguageBloc>();
  final appThemeBloc = app_injector.Injector.resolve<AppThemeBloc>();

  await app_injector.Injector.resolve<FeatureFlagUpdater>().setup();

  runApp(
    App(
      languageBloc: languageBloc,
      appThemeBloc: appThemeBloc,
    ),
  );
}

void _configureInjector() {
  // main injector needs to be first, since it clears kiwi container
  app_injector.Injector.init();
  dashboard_injector.Injector.init();
  login_injector.Injector.init();
  product_injector.Injector.init();
  stock_injector.Injector.init();
  transaction_injector.Injector.init();
  module_common_injector.Injector.init();
  ui_kit_injector.Injector.init();
}
