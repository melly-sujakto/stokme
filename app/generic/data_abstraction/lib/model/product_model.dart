import 'package:data_abstraction/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
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
      saleNet: json['sale_net'],
      storeId: json['store_id'],
    );
  }
}
