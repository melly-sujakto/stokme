import 'package:data_abstraction/entity/sale_entity.dart';

class SaleModel extends SaleEntity {
  SaleModel({
    super.id,
    required super.productEntity,
    required super.receiptId,
    required super.total,
    required super.totalNet,
  });

  factory SaleModel.fromEntity(SaleEntity entity) {
    return SaleModel(
      id: entity.id,
      productEntity: entity.productEntity,
      receiptId: entity.receiptId,
      total: entity.total,
      totalNet: entity.totalNet,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'product_id': productEntity.id,
      'receipt_id': receiptId,
      'total': total,
      'total_net': totalNet,
    };
  }
}
