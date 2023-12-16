import 'package:feature_stock/common/injector/injector.dart';
import 'package:feature_stock/presentation/bloc/stock_bloc.dart';
import 'package:feature_stock/presentation/stock_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class Routes {
  static const stockList = 'stock_list';

  static Map<String, WidgetBuilder> get all {
    final bloc = Injector.resolve<StockBloc>();
    return {
      stockList: (ctx) => BlocProvider(
            create: (context) => bloc,
            child: const StockPage(),
          ),
    };
  }
}
