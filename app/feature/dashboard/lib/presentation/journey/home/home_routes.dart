import 'package:feature_dashboard/presentation/journey/home/home_page.dart';
import 'package:flutter/material.dart';

abstract class HomeRoutes {
  static const home = 'home_initial';

  static final Map<String, WidgetBuilder> all = {
    home: (ctx) => const HomePage(),
  };
}
