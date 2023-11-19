import 'package:feature_stock/presentation/journey/stock_list/stock_list_routes.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static String get stockList => StockListRoutes.stockList;

  static Map<String, WidgetBuilder> get all {
    return {
      ...StockListRoutes.all,
    };
  }
}
