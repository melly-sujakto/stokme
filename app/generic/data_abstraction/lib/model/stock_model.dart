import 'package:data_abstraction/entity/stock_entity.dart';
import 'package:data_abstraction/model/product_model.dart';

class StockModel extends StockEntity {
  StockModel({
    super.id,
    required super.totalPcs,
    required super.productEntity,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      id: json['id'],
      totalPcs: json['total_pcs'],
      productEntity: ProductModel.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toFirestoreJson(
    String savedStoreId, {
    String? overridedProductId,
  }) {
    return {
      'id': id,
      'total_pcs': totalPcs,
      'product_id': overridedProductId ?? productEntity.id,
      'store_id': savedStoreId,
    };
  }
}
