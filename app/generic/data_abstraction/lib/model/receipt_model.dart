import 'package:data_abstraction/entity/receipt_entity.dart';
import 'package:data_abstraction/utils/json_utils.dart';

class ReceiptModel extends ReceiptEntity {
  ReceiptModel({
    super.id,
    required super.cash,
    required super.change,
    required super.totalGross,
    required super.discount,
    required super.totalNet,
    required super.totalPcs,
    required super.userEmail,
    required super.userName,
    super.createdBy,
    super.createdAt,
    super.updatedBy,
    super.updatedAt,
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) {
    return ReceiptModel(
      id: json['id'],
      cash: JsonUtils.validateIntOrDouble(json['cash']),
      change: JsonUtils.validateIntOrDouble(json['change']),
      totalGross: JsonUtils.validateIntOrDouble(json['total_gross']),
      discount: JsonUtils.validateIntOrDouble(json['discount']),
      totalNet: JsonUtils.validateIntOrDouble(json['total_net']),
      totalPcs: json['total_pcs'],
      userEmail: json['user_email'],
      userName: json['user_name'],
      createdAt: json['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['created_at'])
          : null,
      createdBy: json['created_by'],
      updatedAt: json['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['updated_at'])
          : null,
      updatedBy: json['updated_by'],
    );
  }

  factory ReceiptModel.fromEntity(ReceiptEntity entity) {
    return ReceiptModel(
      id: entity.id,
      cash: entity.cash,
      change: entity.change,
      totalGross: entity.totalGross,
      discount: entity.discount,
      totalNet: entity.totalNet,
      totalPcs: entity.totalPcs,
      userEmail: entity.userEmail,
      userName: entity.userName,
      createdAt: entity.createdAt,
      createdBy: entity.createdBy,
      updatedAt: entity.updatedAt,
      updatedBy: entity.updatedBy,
    );
  }

  Map<String, dynamic> toFirestoreJson(
    String overridedStoreId, {
    DateTime? overridedCreatedAt,
    String? overridedCreatedBy,
    DateTime? overridedUpdatedAt,
    String? overridedUpdatedBy,
  }) {
    return {
      'cash': cash,
      'change': change,
      'total_gross': totalGross,
      'discount': discount,
      'total_net': totalNet,
      'total_pcs': totalPcs,
      'user_email': userEmail,
      'user_name': userName,
      'store_id': overridedStoreId,
      'created_at': (overridedCreatedAt ?? createdAt)?.millisecondsSinceEpoch,
      'created_by': overridedCreatedBy ?? createdBy,
      'updated_at': (overridedUpdatedAt ?? updatedAt)?.millisecondsSinceEpoch,
      'updated_by': overridedUpdatedBy ?? updatedBy,
    };
  }
}
