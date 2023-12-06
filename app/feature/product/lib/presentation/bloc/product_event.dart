part of 'product_bloc.dart';

sealed class ProductEvent {}

class GetProductListEvent extends ProductEvent {
  final bool filterByUnsetPrice;
  final String filterValue;

  GetProductListEvent({
    this.filterByUnsetPrice = false,
    this.filterValue = '',
  });
}

class UpdateProductEvent extends ProductEvent {
  final ProductEntity productEntity;

  UpdateProductEvent(this.productEntity);
}
