import 'package:data_abstraction/entity/product_entity.dart';
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

  factory StockModel.forInitStock({
    required String productId,
    required int totalPcs,
    required DateTime createdAt,
    required String createdBy,
  }) {
    return StockModel(
      totalPcs: totalPcs,
      createdAt: createdAt,
      createdBy: createdBy,
      // bypass product with empty values
      productEntity: ProductEntity(
        id: productId,
        code: '',
        name: '',
        saleNet: 0,
      ),
    );
  }

  factory StockModel.forUpdateStock({
    required String productId,
    required int totalPcs,
    required DateTime createdAt,
    required String createdBy,
    required DateTime updatedAt,
    required String updatedBy,
  }) {
    return StockModel(
      totalPcs: totalPcs,
      createdAt: createdAt,
      createdBy: createdBy,
      updatedAt: updatedAt,
      updatedBy: updatedBy,
      // bypass product with empty values
      productEntity: ProductEntity(
        id: productId,
        code: '',
        name: '',
        saleNet: 0,
      ),
    );
  }

  Map<String, dynamic> toFirestoreJson(
    String savedStoreId, {
    required  bool isActive,
    String? overridedProductId,
    DateTime? overridedCreatedAt,
    String? overridedCreatedBy,
    DateTime? overridedUpdatedAt,
    String? overridedUpdatedBy,
  }) {
    return {
      'total_pcs': totalPcs,
      'product_id': overridedProductId ?? productEntity.id,
      'store_id': savedStoreId,
      'is_active': isActive,
      'created_at': (overridedCreatedAt ?? createdAt)?.millisecondsSinceEpoch,
      'created_by': overridedCreatedBy ?? createdBy,
      'updated_at': (overridedUpdatedAt ?? updatedAt)?.millisecondsSinceEpoch,
      'updated_by': overridedUpdatedBy ?? updatedBy,
    };
  }
}
