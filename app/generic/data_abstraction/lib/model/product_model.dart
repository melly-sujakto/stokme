import 'package:data_abstraction/entity/product_entity.dart';
import 'package:data_abstraction/utils/json_utils.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    super.id,
    required super.code,
    required super.name,
    required super.saleNet,
    required super.storeId,
    super.createdBy,
    super.createdAt,
    super.updatedBy,
    super.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      saleNet: JsonUtils.validateIntOrDouble(json['sale_net']),
      storeId: json['store_id'],
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

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      code: entity.code,
      saleNet: entity.saleNet,
      name: entity.name,
      storeId: entity.storeId,
      createdAt: entity.createdAt,
      createdBy: entity.createdBy,
      updatedAt: entity.updatedAt,
      updatedBy: entity.updatedBy,
    );
  }

  Map<String, dynamic> toFirestoreJson({
    String? overridedStoreId,
    DateTime? overridedCreatedAt,
    String? overridedCreatedBy,
    DateTime? overridedUpdatedAt,
    String? overridedUpdatedBy,
  }) {
    return {
      'code': code,
      'name': name,
      'sale_net': saleNet,
      'store_id': overridedStoreId ?? storeId,
      'created_at': (overridedCreatedAt ?? createdAt)?.millisecondsSinceEpoch,
      'created_by': overridedCreatedBy ?? createdBy,
      'updated_at': (overridedUpdatedAt ?? updatedAt)?.millisecondsSinceEpoch,
      'updated_by': overridedUpdatedBy ?? updatedBy,
    };
  }
}
