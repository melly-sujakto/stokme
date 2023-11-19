import 'package:feature_stock/presentation/journey/stock_list/stock_list_page.dart';
import 'package:flutter/material.dart';

abstract class StockListRoutes {
  static const stockList = 'stock_list';

  static final Map<String, WidgetBuilder> all = {
    stockList: (ctx) => const StockListPage(),
  };
}
