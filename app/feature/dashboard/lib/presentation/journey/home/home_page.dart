import 'package:feature_dashboard/common/injector/injector.dart';
import 'package:feature_dashboard/domain/navigation/interaction_navigation.dart';
import 'package:feature_dashboard/presentation/journey/home/home_constants.dart';
import 'package:flutter/material.dart';
import 'package:module_common/i18n/i18n_extension.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$runtimeType'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Injector.resolve<DashboardInteractionNavigation>()
                    .navigateToSale(context);
              },
              child: Text(HomeStrings.saleButtonTitle.i18n(context)),
            ),
            ElevatedButton(
              onPressed: () {
                Injector.resolve<DashboardInteractionNavigation>()
                    .navigateToStockIn(context);
              },
              child: Text(HomeStrings.stockInButtonTitle.i18n(context)),
            ),
            ElevatedButton(
              onPressed: () {
                Injector.resolve<DashboardInteractionNavigation>()
                    .navigateToProduct(context);
              },
              child: Text(HomeStrings.productButtonTitle.i18n(context)),
            ),
            ElevatedButton(
              onPressed: () {
                Injector.resolve<DashboardInteractionNavigation>()
                    .navigateToStock(context);
              },
              child: Text(HomeStrings.stockButtonTitle.i18n(context)),
            ),
            ElevatedButton(
              onPressed: () {
                Injector.resolve<DashboardInteractionNavigation>()
                    .navigateToTransaction(context);
              },
              child: Text(HomeStrings.transactionButtonTitle.i18n(context)),
            ),
          ],
        ),
      ),
    );
  }
}
