part of 'sale_bloc.dart';

sealed class SaleEvent {}

class SetupEvent extends SaleEvent {}

class PrepareDataEvent extends SaleEvent {}

class CalculatePriceProductEvent extends SaleEvent {
  final ProductEntity product;
  final int totalPcs;

  CalculatePriceProductEvent({
    required this.product,
    required this.totalPcs,
  });
}

class CalculateTotalPriceEvent extends SaleEvent {
  final List<SaleEntity> saleEntityList;

  CalculateTotalPriceEvent(this.saleEntityList);
}

class SubmitReceiptAndSalesEvent extends SaleEvent {
  final List<SaleEntity> saleEntityList;

  SubmitReceiptAndSalesEvent(this.saleEntityList);
}

class GetStoreDetailEvent extends SaleEvent {}

class GetSalesByReceiptIdEvent extends SaleEvent {
  final String receiptId;

  GetSalesByReceiptIdEvent(this.receiptId);
}
