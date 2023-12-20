part of 'sale_bloc.dart';

sealed class SaleState {}

final class SaleInitial extends SaleState {}

final class GetProductListLoading extends SaleState {}

final class GetProductListFailed extends SaleState {}

final class GetProductListLoaded extends SaleState {
  final List<ProductEntity> products;

  GetProductListLoaded(this.products);
}
