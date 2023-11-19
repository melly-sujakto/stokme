import 'package:feature_product/presentation/journey/product_list/home_routes.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static String get productList => ProductListRoutes.productList;

  static Map<String, WidgetBuilder> get all {
    return {
      ...ProductListRoutes.all,
    };
  }
}
