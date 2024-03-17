import 'package:data_abstraction/entity/base/base_entity.dart';
import 'package:data_abstraction/entity/product_entity.dart';

class StockEntity extends BaseEntity {
  final String? id;
  final int totalPcs;
  final ProductEntity productEntity;

  StockEntity({
    this.id,
    required this.totalPcs,
    required this.productEntity,
    super.createdBy,
    super.createdAt,
    super.updatedBy,
    super.updatedAt,
  });
}
