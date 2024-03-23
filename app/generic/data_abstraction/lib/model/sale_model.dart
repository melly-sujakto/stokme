import 'package:data_abstraction/entity/sale_entity.dart';
import 'package:data_abstraction/model/product_model.dart';
import 'package:data_abstraction/utils/json_utils.dart';

class SaleModel extends SaleEntity {
  SaleModel({
    super.id,
    required super.productEntity,
    required super.receiptId,
    required super.totalPcs,
    required super.totalNet,
    super.createdBy,
    super.createdAt,
    super.updatedBy,
    super.updatedAt,
  });

    factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      id: json['id'], 
      productEntity: ProductModel.fromJson(json['product']),
      receiptId: json['receipt_id'],
      totalNet: JsonUtils.validateIntOrDouble(json['total_net']),
      totalPcs: json['total_pcs'],
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

  factory SaleModel.fromEntity(SaleEntity entity) {
    return SaleModel(
      id: entity.id,
      productEntity: entity.productEntity,
      receiptId: entity.receiptId,
      totalPcs: entity.totalPcs,
      totalNet: entity.totalNet,
      createdAt: entity.createdAt,
      createdBy: entity.createdBy,
      updatedAt: entity.updatedAt,
      updatedBy: entity.updatedBy,
    );
  }

  Map<String, dynamic> toFirestoreJson(
    String overridedStoreId, {
    DateTime? overridedCreatedAt,
    String? overridedCreatedBy,
    DateTime? overridedUpdatedAt,
    String? overridedUpdatedBy,
  }) {
    return {
      'product_id': productEntity.id,
      'receipt_id': receiptId,
      'total_pcs': totalPcs,
      'total_net': totalNet,
      'store_id': overridedStoreId,
      'created_at': (overridedCreatedAt ?? createdAt)?.millisecondsSinceEpoch,
      'created_by': overridedCreatedBy ?? createdBy,
      'updated_at': (overridedUpdatedAt ?? updatedAt)?.millisecondsSinceEpoch,
      'updated_by': overridedUpdatedBy ?? updatedBy,
    };
  }
}
