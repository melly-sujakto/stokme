import 'package:data_abstraction/entity/sale_entity.dart';

class SaleModel extends SaleEntity {
  SaleModel({
    required super.id,
    required super.productEntity,
    required super.receiptId,
    required super.total,
    required super.totalNet,
  });
}
