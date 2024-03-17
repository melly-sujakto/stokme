import 'package:data_abstraction/entity/base/base_entity.dart';

class ReceiptEntity extends BaseEntity {
  final String? id;
  final double cash;
  final double change;
  final double totalGross;
  final double discount;
  final double totalNet;
  final String userEmail;

  ReceiptEntity({
    this.id,
    required this.cash,
    required this.change,
    required this.totalGross,
    required this.discount,
    required this.totalNet,
    required this.userEmail,
    super.createdBy,
    super.createdAt,
    super.updatedBy,
    super.updatedAt,
  });

  ReceiptEntity copyWith({
    String? id,
    double? cash,
    double? change,
    double? totalGross,
    double? discount,
    double? totalNet,
    String? userEmail,
    DateTime? createdAt,
    String? createdBy,
    DateTime? updatedAt,
    String? updatedBy,
  }) {
    return ReceiptEntity(
      id: id ?? this.id,
      cash: cash ?? this.cash,
      change: change ?? this.change,
      totalGross: totalGross ?? this.totalGross,
      discount: discount ?? this.discount,
      totalNet: totalNet ?? this.totalNet,
      userEmail: userEmail ?? this.userEmail,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }
}
