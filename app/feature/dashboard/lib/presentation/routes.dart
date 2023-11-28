import 'package:feature_dashboard/common/injector/injector.dart';
import 'package:feature_dashboard/presentation/dashboard_page.dart';
import 'package:feature_dashboard/presentation/journey/more/bloc/more_bloc.dart';
import 'package:flutter/material.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

abstract class Routes {
  static String get initial => 'dashboard';

  static Map<String, WidgetBuilder> get all {
    return {
      initial: (context) => BlocProvider.value(
            value: Injector.resolve<MoreBloc>(),
            child: const DashboardPage(),
          ),
    };
  }
}
