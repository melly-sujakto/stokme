import 'package:feature_login/common/injector/injector.dart';
import 'package:feature_login/presentation/bloc/login_bloc.dart';
import 'package:feature_login/presentation/login_page.dart';
import 'package:flutter/material.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

abstract class Routes {
  static String get login => 'login';

  static Map<String, WidgetBuilder> get all {
    return {
      login: (context) => BlocProvider<LoginBloc>.value(
            value: Injector.resolve<LoginBloc>(),
            child: LoginPage(),
          ),
    };
  }
}
