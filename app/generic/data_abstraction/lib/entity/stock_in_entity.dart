import 'package:data_abstraction/entity/base/base_entity.dart';
import 'package:data_abstraction/entity/product_entity.dart';

class StockInEntity extends BaseEntity {
  final String? id;
  final ProductEntity productEntity;
  final int totalPcs;
  final double purchaseNet;
  String supplierId;
  String supplierPIC;
  final String userEmail;

  StockInEntity({
    this.id,
    required this.productEntity,
    required this.totalPcs,
    required this.purchaseNet,
    required this.userEmail,
    super.createdBy,
    super.createdAt,
    super.updatedBy,
    super.updatedAt,
    this.supplierId = '',
    this.supplierPIC = '',
  });
}
