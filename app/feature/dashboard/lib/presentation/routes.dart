import 'package:feature_dashboard/common/injector/injector.dart';
import 'package:feature_dashboard/presentation/dashboard_page.dart';
import 'package:feature_dashboard/presentation/journey/home/bloc/home_bloc.dart';
import 'package:feature_dashboard/presentation/journey/more/bloc/more_bloc.dart';
import 'package:feature_dashboard/presentation/journey/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

abstract class Routes {
  static String get initial => 'dashboard';

  static Map<String, WidgetBuilder> get all {
    return {
      initial: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: Injector.resolve<HomeBloc>()..add(GetFeaturesEvent()),
              ),
              BlocProvider.value(
                value: Injector.resolve<MoreBloc>(),
              ),
              BlocProvider(
                create: (context) => Injector.resolve<ProfileBloc>()
                  ..add(
                    GetProfileEvent(),
                  ),
              ),
            ],
            child: const DashboardPage(),
          ),
    };
  }
}
