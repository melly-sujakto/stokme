import 'package:feature_transaction/common/injector/injector.dart';
import 'package:feature_transaction/presentation/journey/transaction_list/bloc/transaction_list_bloc.dart';
import 'package:feature_transaction/presentation/journey/transaction_list/transaction_list_page.dart';
import 'package:feature_transaction/presentation/journey/transaction_list/transaction_sale_detail.dart';
import 'package:flutter/material.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

abstract class TransactionListRoutes {
  static const transactionList = 'transaction_list';
  static const transactionSaleDetail = 'transaction_sale_detail';

  static final Map<String, WidgetBuilder> all = {
    transactionList: (ctx) {
      final transactionListBloc = Injector.resolve<TransactionListBloc>();

      return BlocProvider(
        create: (context) => transactionListBloc,
        child: TransactionListPage(transactionListBloc: transactionListBloc),
      );
    },
    transactionSaleDetail: (ctx) => const TransactionSaleDetail(),
  };
}
