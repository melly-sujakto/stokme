part of 'product_bloc.dart';

sealed class ProductEvent {}

class GetProductListEvent extends ProductEvent {
  final bool filterByUnsetPrice;
  final bool forceRemote;
  final String filterValue;

  GetProductListEvent({
    this.filterByUnsetPrice = false,
    this.forceRemote = false,
    this.filterValue = '',
  });
}

class UpdateProductEvent extends ProductEvent {
  final ProductEntity productEntity;

  UpdateProductEvent(this.productEntity);
}
