import 'package:data_abstraction/entity/stock_in_entity.dart';
import 'package:data_abstraction/model/product_model.dart';
import 'package:data_abstraction/utils/json_utils.dart';

class StockInModel extends StockInEntity {
  StockInModel({
    super.id,
    required super.productEntity,
    required super.totalPcs,
    required super.purchaseNet,
    required super.userEmail,
    required super.userName,
    super.supplierId,
    super.supplierName,
    super.supplierPIC,
    super.createdBy,
    super.createdAt,
    super.updatedBy,
    super.updatedAt,
  });

  factory StockInModel.fromJson(Map<String, dynamic> json) {
    return StockInModel(
      id: json['id'],
      productEntity: ProductModel.fromJson(json['product']),
      totalPcs: json['total_pcs'],
      purchaseNet: JsonUtils.validateIntOrDouble(json['purchase_net']),
      userEmail: json['user_email'],
      userName: json['user_name'],
      supplierId: json['supplier_id'],
      supplierName: json['supplier_name'],
      supplierPIC: json['supplier_pic'],
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
      'supplier_id': supplierId,
      'supplier_name': supplierName,
      'supplier_pic': supplierPIC,
      'user_email': userEmail,
      'user_name': userName,
      'created_at': (overridedCreatedAt ?? createdAt)?.millisecondsSinceEpoch,
      'created_by': overridedCreatedBy ?? createdBy,
      'updated_at': (overridedUpdatedAt ?? updatedAt)?.millisecondsSinceEpoch,
      'updated_by': overridedUpdatedBy ?? updatedBy,
    };
  }

  factory StockInModel.fromEntity(StockInEntity entity) {
    return StockInModel(
      id: entity.id,
      productEntity: entity.productEntity,
      totalPcs: entity.totalPcs,
      purchaseNet: entity.purchaseNet,
      userEmail: entity.userEmail,
      userName: entity.userName,
      supplierId: entity.supplierId,
      supplierName: entity.supplierName,
      supplierPIC: entity.supplierPIC,
      createdAt: entity.createdAt,
      createdBy: entity.createdBy,
      updatedAt: entity.updatedAt,
      updatedBy: entity.updatedBy,
    );
  }
}
