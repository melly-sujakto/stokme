import 'package:feature_dashboard/presentation/routes.dart' as dashboard_routes;
import 'package:feature_login/common/injector/injector.dart';
import 'package:feature_login/presentation/bloc/login_bloc.dart';
import 'package:feature_login/presentation/routes.dart' as login_routes;
import 'package:feature_product/presentation/routes.dart' as product_routes;
import 'package:feature_stock/presentation/routes.dart' as stock_routes;
import 'package:feature_transaction/presentation/routes.dart'
    as transaction_routes;
import 'package:flutter/material.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:stokme/presentation/splash/splash_page.dart';

abstract class Routes {
  static String get initial => 'splash';

  static Map<String, WidgetBuilder> get all {
    return {
      initial: (context) {
        return BlocProvider.value(
          value: Injector.resolve<LoginBloc>(),
          child: const SplashPage(),
        );
      },
      ...dashboard_routes.Routes.all,
      ...login_routes.Routes.all,
      ...product_routes.Routes.all,
      ...stock_routes.Routes.all,
      ...transaction_routes.Routes.all,
    };
  }

  // static Route getRoutesWithSettings(RouteSettings settings) {
  //   final routeName = settings.name;

  //   Route routeTo(WidgetBuilder builder) {
  //     return MaterialPageRoute(builder: builder, settings: settings);
  //   }

  //   if (all.containsKey(routeName)) {
  //     return routeTo(all[routeName]!);
  //   }

  //   if (card_routes.Routes.getRoutesWithSettings(settings)
  //       .containsKey(routeName)) {
  //     return routeTo(
  //       card_routes.Routes.getRoutesWithSettings(settings)[routeName]!,
  //     );
  //   }

  //   if (subscription_routes.Routes.getRoutesWithSettings(settings)
  //       .containsKey(routeName)) {
  //     return routeTo(
  //       subscription_routes.Routes.getRoutesWithSettings(
  //         settings,
  //       )[routeName]!,
  //     );
  //   }

  //   if (routeName == maintenance) {
  //     return routeTo((context) {
  //       final args = settings.arguments as MaintenanceScreenArgs;
  //       return MaintenanceScreen(
  //         arguments: args,
  //       );
  //     });
  //   }

  //   /// Put Else-If my_routes.Routes.getRoutesWithSettings here
  //   throw Exception('unknown route name');
  // }
}
