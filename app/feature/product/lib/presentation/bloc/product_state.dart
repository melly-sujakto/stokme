part of 'product_bloc.dart';

sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductFailed extends ProductState {}

final class ProductListLoaded extends ProductState {
  final List<ProductEntity> productList;

  ProductListLoaded(this.productList);
}
