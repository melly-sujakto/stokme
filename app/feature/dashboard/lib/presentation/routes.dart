import 'package:feature_dashboard/presentation/dashboard_page.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static String get initial => 'dashboard';

  static Map<String, WidgetBuilder> get all {
    return {
      initial: (context) => const DashboardPage(),
    };
  }
}
