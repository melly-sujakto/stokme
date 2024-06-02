import 'package:data_abstraction/entity/supplier_entity.dart';

class SupplierModel extends SupplierEntity {
  SupplierModel({
    super.id,
    required super.name,
    required super.phone,
    super.isActive,
    super.createdBy,
    super.createdAt,
    super.updatedBy,
    super.updatedAt,
  });

  factory SupplierModel.fromJson(Map<String, dynamic> json) {
    return SupplierModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      isActive: json['is_active'],
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
}
