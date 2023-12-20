part of 'sale_bloc.dart';

sealed class SaleEvent {}

class GetProductListEvent extends SaleEvent {
  final String filterValue;
  GetProductListEvent({
    required this.filterValue,
  });
}

class CalculatePriceProductEvent extends SaleEvent {
  final ProductEntity product;
  final int total;

  CalculatePriceProductEvent({
    required this.product,
    required this.total,
  });
}
