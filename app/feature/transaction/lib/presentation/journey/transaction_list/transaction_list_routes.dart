import 'package:data_abstraction/entity/receipt_entity.dart';
import 'package:feature_transaction/common/injector/injector.dart';
import 'package:feature_transaction/presentation/blocs/print_bloc/print_bloc.dart';
import 'package:feature_transaction/presentation/journey/sale/bloc/sale_bloc.dart';
import 'package:feature_transaction/presentation/journey/sale/screens/sale_detail_page.dart';
import 'package:feature_transaction/presentation/journey/transaction_list/bloc/transaction_list_bloc.dart';
import 'package:feature_transaction/presentation/journey/transaction_list/transaction_list_page.dart';
import 'package:flutter/material.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

abstract class TransactionListRoutes {
  static const transactionList = 'transaction_list';
  static const saleDetail = 'sale_detail';

  static final Map<String, WidgetBuilder> all = {
    transactionList: (ctx) {
      final transactionListBloc = Injector.resolve<TransactionListBloc>();

      return BlocProvider(
        create: (context) => transactionListBloc,
        child: TransactionListPage(transactionListBloc: transactionListBloc),
      );
    },
    saleDetail: (ctx) {
      final argument = ModalRoute.of(ctx)!.settings.arguments as ReceiptEntity;
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => Injector.resolve<SaleBloc>()
              ..add(GetStoreDetailEvent())
              ..add(
                GetSalesByReceiptIdEvent(
                  argument.id!,
                ),
              ),
          ),
          BlocProvider(
            create: (context) => Injector.resolve<PrintBloc>(),
          )
        ],
        child: SaleDetailPage(receiptEntity: argument),
      );
    },
  };
}
