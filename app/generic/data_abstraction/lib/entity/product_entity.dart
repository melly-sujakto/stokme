class ProductEntity {
  final String id;
  final String code;
  final String name;
  final int? saleNet;
  final String storeId;

  ProductEntity({
    required this.id,
    required this.code,
    required this.name,
    this.saleNet,
    required this.storeId,
  });
}
