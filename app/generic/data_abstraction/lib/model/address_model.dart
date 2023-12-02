import 'package:data_abstraction/entity/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    required super.street,
    required super.kelurahan,
    required super.kecamatan,
    required super.city,
    required super.province,
    required super.country,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      street: json['street'],
      kelurahan: json['kelurahan'],
      kecamatan: json['kecamatan'],
      city: json['city'],
      province: json['province'],
      country: json['country'],
    );
  }
}
