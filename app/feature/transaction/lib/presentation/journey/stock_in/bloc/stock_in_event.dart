part of 'stock_in_bloc.dart';

sealed class StockInEvent {}

class SubmitStockInEvent extends StockInEvent {
  final StockInEntity stockInEntity;

  SubmitStockInEvent(this.stockInEntity);
}

class AddProductEvent extends StockInEvent {
  final ProductEntity product;

  AddProductEvent(this.product);
}
