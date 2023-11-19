import 'package:feature_product/presentation/journey/product_list/product_list_page.dart';
import 'package:flutter/material.dart';

abstract class ProductListRoutes {
  static const productList = 'product_list';

  static final Map<String, WidgetBuilder> all = {
    productList: (ctx) => const ProductListPage(),
  };
}
