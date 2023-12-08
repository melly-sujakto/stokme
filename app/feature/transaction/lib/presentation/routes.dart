import 'package:feature_transaction/presentation/journey/sale/sale_routes.dart';
import 'package:feature_transaction/presentation/journey/stock_in/stock_in_routes.dart';
import 'package:feature_transaction/presentation/journey/transaction_list/transaction_list_routes.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static String get stockIn => StockInRoutes.stockIn;
  static String get sale => SaleRoutes.salesInput;
  static String get transactionList => TransactionListRoutes.transactionList;

  static Map<String, WidgetBuilder> get all {
    return {
      ...StockInRoutes.all,
      ...SaleRoutes.all,
      ...TransactionListRoutes.all,
    };
  }
}
