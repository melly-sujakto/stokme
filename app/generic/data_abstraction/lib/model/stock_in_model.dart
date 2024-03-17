import 'package:data_abstraction/entity/stock_in_entity.dart';

class StockInModel extends StockInEntity {
  StockInModel({
    required super.productEntity,
    required super.totalPcs,
    required super.purchaseNet,
    super.createdBy,
    super.createdAt,
    super.updatedBy,
    super.updatedAt,
  });

  Map<String, dynamic> toFirestoreJson(
    String storeId, {
    DateTime? overridedCreatedAt,
    String? overridedCreatedBy,
    DateTime? overridedUpdatedAt,
    String? overridedUpdatedBy,
  }) {
    return {
      'product_id': productEntity.id,
      'total_pcs': totalPcs,
      'purchase_net': purchaseNet,
      'store_id': storeId,
      'created_at': (overridedCreatedAt ?? createdAt)?.millisecondsSinceEpoch,
      'created_by': overridedCreatedBy ?? createdBy,
      'updated_at': (overridedUpdatedAt ?? updatedAt)?.millisecondsSinceEpoch,
      'updated_by': overridedUpdatedBy ?? updatedBy,
    };
  }

  factory StockInModel.fromEntity(StockInEntity entity) {
    return StockInModel(
      productEntity: entity.productEntity,
      totalPcs: entity.totalPcs,
      purchaseNet: entity.purchaseNet,
      createdAt: entity.createdAt,
      createdBy: entity.createdBy,
      updatedAt: entity.updatedAt,
      updatedBy: entity.updatedBy,
    );
  }
}
