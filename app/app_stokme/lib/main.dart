import 'package:feature_dashboard/common/injector/injector.dart'
    as dashboard_injector;
import 'package:feature_product/common/injector/injector.dart'
    as product_injector;
import 'package:feature_stock/common/injector/injector.dart' as stock_injector;
import 'package:feature_transaction/common/injector/injector.dart'
    as transaction_injector;
import 'package:flutter/material.dart';
import 'package:stokme/common/injector/injector.dart' as app_injector;
import 'package:stokme/presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _configureInjector();
  runApp(const App());
}

void _configureInjector() {
  // main injector needs to be first, since it clears kiwi container
  app_injector.Injector.init();
  dashboard_injector.Injector.init();
  product_injector.Injector.init();
  stock_injector.Injector.init();
  transaction_injector.Injector.init();
}
