import 'package:data_abstraction/entity/store_entity.dart';
import 'package:data_abstraction/model/address_model.dart';

class StoreModel extends StoreEntity {
  StoreModel({
    required super.id,
    required super.name,
    required super.address,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      name: json['name'],
      address: AddressModel.fromJson(json['address']),
    );
  }
}
