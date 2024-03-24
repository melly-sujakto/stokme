import 'package:data_abstraction/entity/base/base_entity.dart';
import 'package:data_abstraction/entity/product_entity.dart';

class StockInEntity extends BaseEntity {
  final String? id;
  final ProductEntity productEntity;
  final int totalPcs;
  final double purchaseNet;

  StockInEntity({
    this.id,
    required this.productEntity,
    required this.totalPcs,
    required this.purchaseNet,
    super.createdBy,
    super.createdAt,
    super.updatedBy,
    super.updatedAt,
  });
}
