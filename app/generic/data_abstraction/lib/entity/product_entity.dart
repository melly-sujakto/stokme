class ProductEntity {
  final String? id;
  final String code;
  final String name;
  final double? saleNet;
  final String storeId;

  ProductEntity({
    this.id,
    required this.code,
    required this.name,
    this.saleNet,
    required this.storeId,
  });
}
