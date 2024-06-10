import 'package:data_abstraction/entity/base/base_entity.dart';
import 'package:data_abstraction/entity/product_entity.dart';

class StockInEntity extends BaseEntity {
  final String? id;
  final ProductEntity productEntity;
  final int totalPcs;
  final double purchaseNet;
  String supplierId;
  String supplierName;
  String supplierPIC;
  final String userEmail;
  final String userName;

  StockInEntity({
    this.id,
    required this.productEntity,
    required this.totalPcs,
    required this.purchaseNet,
    required this.userEmail,
    required this.userName,
    super.createdBy,
    super.createdAt,
    super.updatedBy,
    super.updatedAt,
    this.supplierId = '',
    this.supplierName = '',
    this.supplierPIC = '',
  });

  StockInEntity copyWith({
    String? id,
    ProductEntity? productEntity,
    int? totalPcs,
    double? purchaseNet,
    String? supplierId,
    String? supplierName,
    String? supplierPIC,
    String? userEmail,
    String? userName,
  }) {
    return StockInEntity(
      id: id ?? this.id,
      totalPcs: totalPcs ?? this.totalPcs,
      userEmail: userEmail ?? this.userEmail,
      userName: userName ?? this.userName,
      productEntity: productEntity ?? this.productEntity,
      purchaseNet: purchaseNet ?? this.purchaseNet,
      supplierId: supplierId ?? this.supplierId,
      supplierName: supplierName ?? this.supplierName,
      supplierPIC: supplierPIC ?? this.supplierPIC,
      createdAt: createdAt,
      createdBy: createdBy,
      updatedAt: updatedAt,
      updatedBy: updatedBy,
    );
  }
}
