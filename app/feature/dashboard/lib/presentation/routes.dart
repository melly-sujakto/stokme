import 'package:feature_dashboard/presentation/journey/home/home_routes.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static String get initial => HomeRoutes.home;

  static Map<String, WidgetBuilder> get all {
    return {
      ...HomeRoutes.all,
    };
  }
}
