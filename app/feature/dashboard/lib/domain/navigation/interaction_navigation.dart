import 'package:flutter/material.dart';

abstract class DashboardInteractionNavigation {
  void navigateToSale(BuildContext context);

  void navigateToStockIn(BuildContext context);

  void navigateToProduct(BuildContext context);

  void navigateToStock(BuildContext context);

  void navigateToTransaction(BuildContext context);
}
