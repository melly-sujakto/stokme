import 'package:data_abstraction/entity/address_entity.dart';

class StoreEntity {
  final String id;
  final String name;
  final String phone;
  final AddressEntity address;

  StoreEntity({
   required this.id,
   required this.name,
   required this.phone,
   required this.address,
  });
}
