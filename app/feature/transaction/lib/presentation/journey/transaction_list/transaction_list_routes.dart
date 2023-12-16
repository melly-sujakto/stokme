import 'package:feature_transaction/presentation/journey/transaction_list/transaction_list_page.dart';
import 'package:feature_transaction/presentation/journey/transaction_list/transaction_sale_detail.dart';
import 'package:flutter/material.dart';

abstract class TransactionListRoutes {
  static const transactionList = 'transaction_list';
  static const transactionSaleDetail = 'transaction_sale_detail';

  static final Map<String, WidgetBuilder> all = {
    transactionList: (ctx) => const TransactionListPage(),
    transactionSaleDetail: (ctx) => const TransactionSaleDetail(),
  };
}
