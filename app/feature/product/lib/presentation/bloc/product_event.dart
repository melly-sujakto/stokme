part of 'product_bloc.dart';

sealed class ProductEvent {}

class GetProductListEvent extends ProductEvent {
  final bool filterByUnsetPrice;
  final String filterValue;
  final ProductEntity? lastProduct;
  final int index;
  final int pageSize;

  GetProductListEvent({
    this.filterByUnsetPrice = false,
    this.filterValue = '',
    this.lastProduct,
    this.index = 0,
    this.pageSize = 20,
  });
}

class UpdateProductEvent extends ProductEvent {
  final ProductEntity productEntity;

  UpdateProductEvent(this.productEntity);
}

class DeleteProductEvent extends ProductEvent {
  final ProductEntity productEntity;

  DeleteProductEvent(this.productEntity);
}

class AddProductEvent extends ProductEvent {
  final ProductEntity product;

  AddProductEvent(this.product);
}
