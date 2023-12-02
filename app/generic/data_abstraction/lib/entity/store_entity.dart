import 'package:data_abstraction/entity/address_entity.dart';

class StoreEntity {
  final String id;
  final String name;
  final AddressEntity address;

  StoreEntity({
   required this.id,
   required this.name,
   required this.address,
  });
}
