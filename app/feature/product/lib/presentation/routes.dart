import 'package:feature_product/common/injector/injector.dart';
import 'package:feature_product/presentation/bloc/product_bloc.dart';
import 'package:feature_product/presentation/product_page.dart';
import 'package:flutter/material.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

abstract class Routes {
  static String get productList => 'product_list';

  static Map<String, WidgetBuilder> get all {
    return {
      productList: (ctx) {
        final bloc = Injector.resolve<ProductBloc>();
        return BlocProvider(
          create: (context) => bloc,
          child: ProductPage(bloc: bloc),
        );
      }
    };
  }
}
