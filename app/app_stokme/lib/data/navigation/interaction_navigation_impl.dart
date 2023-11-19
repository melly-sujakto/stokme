import 'package:feature_dashboard/domain/navigation/interaction_navigation.dart';
import 'package:feature_product/domain/navigation/interaction_navigation.dart';
import 'package:feature_product/presentation/routes.dart' as product_routes;
import 'package:feature_stock/domain/navigation/interaction_navigation.dart';
import 'package:feature_stock/presentation/routes.dart' as stock_routes;
import 'package:feature_transaction/domain/navigation/interaction_navigation.dart';
import 'package:feature_transaction/presentation/routes.dart'
    as transaction_routes;
import 'package:flutter/widgets.dart';

class InteractionNavigationImpl
    implements
        DashboardInteractionNavigation,
        ProductInteractionNavigation,
        StockInteractionNavigation,
        TransactionInteractionNavigation {
  @override
  void navigateToProduct(BuildContext context) {
    Navigator.of(context).pushNamed(product_routes.Routes.productList);
  }

  @override
  void navigateToSale(BuildContext context) {
    Navigator.of(context).pushNamed(transaction_routes.Routes.sale);
  }

  @override
  void navigateToStock(BuildContext context) {
    Navigator.of(context).pushNamed(stock_routes.Routes.stockList);
  }

  @override
  void navigateToStockIn(BuildContext context) {
    Navigator.of(context).pushNamed(transaction_routes.Routes.stockIn);
  }

  @override
  void navigateToTransaction(BuildContext context) {
    Navigator.of(context).pushNamed(transaction_routes.Routes.transactionList);
  }
}
