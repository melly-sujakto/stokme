import 'package:feature_transaction/presentation/journey/stock_in/stock_in_page.dart';
import 'package:flutter/material.dart';

abstract class StockInRoutes {
  static const stockIn = 'stock_in';

  static final Map<String, WidgetBuilder> all = {
    stockIn: (ctx) => const StockInPage(),
  };
}
