import 'package:feature_supplier/presentation/supplier_page.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static const supplierList = 'supplier_list';

  static Map<String, WidgetBuilder> get all {
    return {
      supplierList: (ctx) {
        return const SupplierPage();
      }
    };
  }
}
