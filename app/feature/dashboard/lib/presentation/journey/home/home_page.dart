import 'package:feature_dashboard/common/injector/injector.dart';
import 'package:feature_dashboard/domain/navigation/interaction_navigation.dart';
import 'package:flutter/material.dart';

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
              child: const Text('Ke Penjualan'),
            ),
            ElevatedButton(
              onPressed: () {
                Injector.resolve<DashboardInteractionNavigation>()
                    .navigateToStockIn(context);
              },
              child: const Text('Ke Stok Masuk'),
            ),
            ElevatedButton(
              onPressed: () {
                Injector.resolve<DashboardInteractionNavigation>()
                    .navigateToProduct(context);
              },
              child: const Text('Ke Produk dan Harga'),
            ),
            ElevatedButton(
              onPressed: () {
                Injector.resolve<DashboardInteractionNavigation>()
                    .navigateToStock(context);
              },
              child: const Text('Ke Stok'),
            ),
            ElevatedButton(
              onPressed: () {
                Injector.resolve<DashboardInteractionNavigation>()
                    .navigateToTransaction(context);
              },
              child: const Text('Ke Transaksi'),
            ),
          ],
        ),
      ),
    );
  }
}
