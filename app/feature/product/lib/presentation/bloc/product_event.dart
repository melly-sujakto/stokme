part of 'product_bloc.dart';

sealed class ProductEvent {}

class GetProductListEvent extends ProductEvent {
  final bool filterByUnsetPrice;

  GetProductListEvent({this.filterByUnsetPrice = false});
}
