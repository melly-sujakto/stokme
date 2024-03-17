import 'package:data_abstraction/entity/stock_entity.dart';
import 'package:data_abstraction/model/product_model.dart';

class StockModel extends StockEntity {
  StockModel({
    super.id,
    required super.totalPcs,
    required super.productEntity,
    super.createdBy,
    super.createdAt,
    super.updatedBy,
    super.updatedAt,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      id: json['id'],
      totalPcs: json['total_pcs'],
      productEntity: ProductModel.fromJson(json['product']),
      createdAt: json['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['created_at'])
          : null,
      createdBy: json['created_by'],
      updatedAt: json['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['updated_at'])
          : null,
      updatedBy: json['updated_by'],
    );
  }

  Map<String, dynamic> toFirestoreJson(
    String savedStoreId, {
    String? overridedProductId,
    DateTime? overridedCreatedAt,
    String? overridedCreatedBy,
    DateTime? overridedUpdatedAt,
    String? overridedUpdatedBy,
  }) {
    return {
      'id': id,
      'total_pcs': totalPcs,
      'product_id': overridedProductId ?? productEntity.id,
      'store_id': savedStoreId,
      'created_at': (overridedCreatedAt ?? createdAt)?.millisecondsSinceEpoch,
      'created_by': overridedCreatedBy ?? createdBy,
      'updated_at': (overridedUpdatedAt ?? updatedAt)?.millisecondsSinceEpoch,
      'updated_by': overridedUpdatedBy ?? updatedBy,
    };
  }
}
