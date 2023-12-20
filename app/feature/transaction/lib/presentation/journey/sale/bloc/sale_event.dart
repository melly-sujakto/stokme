part of 'sale_bloc.dart';

sealed class SaleEvent {}

class GetProductListEvent extends SaleEvent {
  final String filterValue;
  GetProductListEvent({
    required this.filterValue,
  });
}
