import 'package:data_abstraction/entity/base/base_entity.dart';

class ProductEntity extends BaseEntity {
  final String? id;
  final String code;
  final String name;
  final double saleNet;

  ProductEntity({
    this.id,
    required this.code,
    required this.name,
    required this.saleNet,
    super.createdBy,
    super.createdAt,
    super.updatedBy,
    super.updatedAt,
  });
}
