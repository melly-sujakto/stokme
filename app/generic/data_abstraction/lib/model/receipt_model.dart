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
    required super.userEmail,
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) {
    return ReceiptModel(
      id: json['id'],
      cash: JsonUtils.validateIntOrDouble(json['cash']),
      change: JsonUtils.validateIntOrDouble(json['change']),
      totalGross: JsonUtils.validateIntOrDouble(json['total_gross']),
      discount: JsonUtils.validateIntOrDouble(json['discount']),
      totalNet: JsonUtils.validateIntOrDouble(json['total_net']),
      userEmail: json['user_email'],
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
      userEmail: entity.userEmail,
    );
  }

  Map<String, dynamic> toFirestoreJson({bool isUpdate = false}) {
    return {
      'cash': cash,
      'change': change,
      'total_gross': totalGross,
      'discount': discount,
      'total_net': totalNet,
      'user_email': userEmail,
      // hardcoded value
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'created_by': userEmail,
      'updated_at': isUpdate ? DateTime.now().millisecondsSinceEpoch : null,
      'updated_by': isUpdate ? userEmail : null,
    };
  }
}
