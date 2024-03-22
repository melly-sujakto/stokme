import 'package:data_abstraction/entity/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProductList({
    bool filterByUnsetPrice = false,
    ProductEntity? lastProduct,
    int index = 0,
    int pageSize = 20,
  });
}
