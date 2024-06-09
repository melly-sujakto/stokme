import 'package:feature_transaction/common/injector/injector.dart';
import 'package:feature_transaction/presentation/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:feature_transaction/presentation/journey/stock_in/bloc/stock_in_bloc.dart';
import 'package:feature_transaction/presentation/journey/stock_in/stock_in_page.dart';
import 'package:feature_transaction/presentation/journey/stock_in/stock_in_supplier_page.dart';
import 'package:flutter/material.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

abstract class StockInRoutes {
  static const stockIn = 'stock_in';
  static const stockInSupplier = 'stock_in_supplier';

  static final Map<String, WidgetBuilder> all = {
    stockIn: (ctx) {
      final transactionBloc = Injector.resolve<TransactionBloc>();
      final stockInBloc = Injector.resolve<StockInBloc>();

      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => transactionBloc,
          ),
          BlocProvider(
            create: (context) => stockInBloc,
          ),
        ],
        child: const StockInPage(),
      );
    },
    stockInSupplier: (ctx) {
      final args =
          ModalRoute.of(ctx)!.settings.arguments as StockInSupplierArgument;

      return BlocProvider.value(
        value: args.stockInBloc,
        child: StockInSupplierPage(
          stockInSupplierArgument: args,
        ),
      );
    },
  };
}
