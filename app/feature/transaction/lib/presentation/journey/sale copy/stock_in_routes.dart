import 'package:feature_transaction/presentation/journey/sale/sale_page.dart';
import 'package:flutter/material.dart';

abstract class SaleRoutes {
  static const sale = 'sale';

  static final Map<String, WidgetBuilder> all = {
    sale: (ctx) => const SalePage(),
  };
}
