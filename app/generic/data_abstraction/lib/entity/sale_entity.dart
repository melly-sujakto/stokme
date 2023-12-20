import 'package:data_abstraction/entity/product_entity.dart';

class SaleEntity {
  final String? id;
  final ProductEntity productEntity;
  final String receiptId;
  final int total;
  final double totalNet;

  SaleEntity({
    this.id,
    required this.productEntity,
    required this.receiptId,
    required this.total,
    required this.totalNet,
  });
}
