import 'package:data_abstraction/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.email,
    required super.name,
    required super.phone,
    required super.roleId,
    required super.storeId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      roleId: json['role_id'],
      storeId: json['store_id'],
    );
  }
}
