import 'package:feature_supplier/common/injector/injector.dart';
import 'package:feature_supplier/presentation/bloc/supplier_bloc.dart';
import 'package:feature_supplier/presentation/supplier_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class Routes {
  static const supplierList = 'supplier_list';

  static Map<String, WidgetBuilder> get all {
    return {
      supplierList: (ctx) {
        return BlocProvider(
          create: (context) => Injector.resolve<SupplierBloc>(),
          child: const SupplierPage(),
        );
      }
    };
  }
}
