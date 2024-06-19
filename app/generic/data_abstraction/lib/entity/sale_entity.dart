import 'package:data_abstraction/entity/base/base_entity.dart';
import 'package:data_abstraction/entity/product_entity.dart';

class SaleEntity extends BaseEntity {
  final String? id;
  final ProductEntity productEntity;
  final String receiptId;
  int totalPcs;
  final double totalNet;

  SaleEntity({
    this.id,
    required this.productEntity,
    required this.receiptId,
    required this.totalPcs,
    required this.totalNet,
    super.createdBy,
    super.createdAt,
    super.updatedBy,
    super.updatedAt,
  });
}
