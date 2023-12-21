import 'package:feature_transaction/common/injector/injector.dart';
import 'package:feature_transaction/presentation/journey/sale/bloc/sale_bloc.dart';
import 'package:feature_transaction/presentation/journey/sale/screens/sale_input_page.dart';
import 'package:feature_transaction/presentation/journey/sale/screens/sale_result_page.dart';
import 'package:feature_transaction/presentation/journey/sale/screens/sale_review_page.dart';
import 'package:flutter/material.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

abstract class SaleRoutes {
  static const salesInput = 'sales_input';
  static const salesReview = 'sales_review';
  static const salesResult = 'sales_result';

  static final Map<String, WidgetBuilder> all = {
    salesInput: (ctx) {
      final saleBloc = Injector.resolve<SaleBloc>();
      return BlocProvider(
        create: (context) => saleBloc,
        child: SaleInputPage(
          saleBloc: saleBloc,
        ),
      );
    },
    salesReview: (ctx) {
      final argument =
          ModalRoute.of(ctx)!.settings.arguments as SaleReviewArgument;
      return SaleReviewPage(
        salesReviewArgument: argument,
      );
    },
    salesResult: (context) => const SaleResultPage(),
  };
}
