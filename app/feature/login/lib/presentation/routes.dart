import 'package:feature_login/presentation/login_page.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static String get login => 'login';

  static Map<String, WidgetBuilder> get all {
    return {
      login: (context) => const LoginPage(),
    };
  }
}
