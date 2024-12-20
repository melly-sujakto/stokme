part of 'sale_bloc.dart';

sealed class SaleState {}

final class SaleInitial extends SaleState {
  final bool isAutoActiveScanner;
  final bool isAvailableEditPrice;

  SaleInitial({
    this.isAutoActiveScanner = false,
    this.isAvailableEditPrice = false,
  });
}

final class GenerateReceiptFinished extends SaleState {}

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

final class SubmitLoading extends SaleState {}

final class SubmitSuccess extends SaleState {
  // TODO(melly): wrap to be one entity
  final List<SaleEntity> saleEntityList;

  SubmitSuccess({required this.saleEntityList});
}

final class SubmitFailed extends SaleState {}

final class GetStoreLoaded extends SaleState {
  final StoreEntity storeEntity;

  GetStoreLoaded(this.storeEntity);
}

final class GetSalesByReceiptIdLoading extends SaleState {}

final class GetSalesByReceiptIdError extends SaleState {}

final class GetSalesByReceiptIdLoaded extends SaleState {
  final List<SaleEntity> saleEntities;

  GetSalesByReceiptIdLoaded(this.saleEntities);
}
