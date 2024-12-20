import 'package:data_abstraction/entity/base/base_entity.dart';

class SupplierEntity extends BaseEntity {
  final String? id;
  final String name;
  final String phone;
  bool isActive;

  SupplierEntity({
    this.id,
    required this.name,
    required this.phone,
    this.isActive = true,
    super.createdBy,
    super.createdAt,
    super.updatedBy,
    super.updatedAt,
  });

  void setInactive() {
    isActive = false;
  }
}
