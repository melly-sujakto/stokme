part of 'sale_bloc.dart';

sealed class SaleState {}

final class SaleInitial extends SaleState {}

final class GetProductListLoading extends SaleState {}

final class GetProductListFailed extends SaleState {}

final class GetProductListLoaded extends SaleState {
  final List<ProductEntity> products;

  GetProductListLoaded(this.products);
}

final class CalculationSuccess extends SaleState {
  final SaleEntity saleEntity;

  CalculationSuccess(this.saleEntity);
}

final class CalculationTotalPriceSuccess extends SaleState {
  final List<SaleEntity> saleEntityList;
  final ReceiptEntity receiptEntity;

  CalculationTotalPriceSuccess({
    required this.saleEntityList,
    required this.receiptEntity,
  });
}
