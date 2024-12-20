part of 'stock_in_bloc.dart';

sealed class StockInEvent {}

class PrepareDataEvent extends StockInEvent {}

class SubmitStockInEvent extends StockInEvent {
  final bool isNewSupplier;
  final SupplierEntity? supplierEntity;

  SubmitStockInEvent({
    required this.isNewSupplier,
    this.supplierEntity,
  });
}

class AddProductEvent extends StockInEvent {
  final ProductEntity product;

  AddProductEvent(this.product);
}

class GetSuppliersEvent extends StockInEvent {}

class UpdateStockInDataEvent extends StockInEvent {
  final StockInEntity stockInEntity;

  UpdateStockInDataEvent(this.stockInEntity);
}
