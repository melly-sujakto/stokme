part of 'product_bloc.dart';

sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductFailed extends ProductState {}

final class UpdateLoading extends ProductState {}

final class UpdateFailed extends ProductState {}

final class UpdateSuccess extends ProductState {}

final class ProductListLoaded extends ProductState {
  final List<ProductEntity> productList;

  ProductListLoaded(this.productList);
}
