import 'package:data_abstraction/entity/product_entity.dart';

class StockEntity {
  final String id;
  final int totalPcs;
  final ProductEntity productEntity;

  StockEntity({
    required this.id,
    required this.totalPcs,
    required this.productEntity,
  });
}
