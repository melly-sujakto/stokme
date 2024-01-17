import 'package:data_abstraction/entity/stock_in_entity.dart';

class StockInModel extends StockInEntity {
  StockInModel({
    required super.productEntity,
    required super.totalPcs,
    required super.purchaseNet,
  });

  Map<String, dynamic> toFirestoreJson() {
    return {
      'product_id': productEntity.id,
      'total_pcs': totalPcs,
      'purchase_net': purchaseNet,
    };
  }

  factory StockInModel.fromEntity(StockInEntity stockInEntity) {
    return StockInModel(
      productEntity: stockInEntity.productEntity,
      totalPcs: stockInEntity.totalPcs,
      purchaseNet: stockInEntity.purchaseNet,
    );
  }
}
