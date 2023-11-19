import 'package:feature_transaction/presentation/journey/transaction_list/transaction_list_page.dart';
import 'package:flutter/material.dart';

abstract class TransactionListRoutes {
  static const transactionList = 'transaction_list';

  static final Map<String, WidgetBuilder> all = {
    transactionList: (ctx) => const TransactionListPage(),
  };
}
