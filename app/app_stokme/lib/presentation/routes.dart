import 'package:feature_dashboard/presentation/routes.dart' as dashboard_routes;
import 'package:feature_login/presentation/routes.dart' as login_routes;
import 'package:feature_product/presentation/routes.dart' as product_routes;
import 'package:feature_stock/presentation/routes.dart' as stock_routes;
import 'package:feature_transaction/presentation/routes.dart'
    as transaction_routes;
import 'package:flutter/material.dart';

abstract class Routes {
  static String get initial => 'initial';

  static Map<String, WidgetBuilder> get all {
    return {
      ...dashboard_routes.Routes.all,
      ...login_routes.Routes.all,
      ...product_routes.Routes.all,
      ...stock_routes.Routes.all,
      ...transaction_routes.Routes.all,
      // initial: (context) =>
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
