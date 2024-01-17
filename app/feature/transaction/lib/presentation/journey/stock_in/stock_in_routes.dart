import 'package:feature_transaction/common/injector/injector.dart';
import 'package:feature_transaction/presentation/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:feature_transaction/presentation/journey/stock_in/stock_in_page.dart';
import 'package:flutter/material.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

abstract class StockInRoutes {
  static const stockIn = 'stock_in';

  static final Map<String, WidgetBuilder> all = {
    stockIn: (ctx) {
      final transactionBloc = Injector.resolve<TransactionBloc>();

      return BlocProvider(
        create: (context) => transactionBloc,
        child: StockInPage(
          transactionBloc: transactionBloc,
        ),
      );
    },
  };
}
