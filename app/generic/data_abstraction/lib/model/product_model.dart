import 'package:data_abstraction/entity/product_entity.dart';
import 'package:data_abstraction/utils/json_utils.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    super.id,
    required super.code,
    required super.name,
    super.saleNet,
    required super.storeId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      saleNet: JsonUtils.validateIntOrDouble(json['sale_net'] ?? 0),
      storeId: json['store_id'],
    );
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      code: entity.code,
      saleNet: entity.saleNet,
      name: entity.name,
      storeId: entity.storeId,
    );
  }

  Map<String, dynamic> toFirestoreJson(String savedStoreId) {
    return {
      'code': code,
      'name': name,
      'sale_net': saleNet ?? 0,
      'store_id': savedStoreId,
    };
  }
}
