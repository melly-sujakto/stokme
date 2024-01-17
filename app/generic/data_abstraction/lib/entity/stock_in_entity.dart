import 'package:data_abstraction/entity/product_entity.dart';

class StockInEntity {
  final ProductEntity productEntity;
  final int totalPcs;
  final double purchaseNet;

  StockInEntity({
    required this.productEntity,
    required this.totalPcs,
    required this.purchaseNet,
  });
}
