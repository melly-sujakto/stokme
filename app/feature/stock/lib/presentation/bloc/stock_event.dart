part of 'stock_bloc.dart';

sealed class StockEvent {}

class GetStockListEvent extends StockEvent {
  final int pageSize;
  final int index;
  final StockFilterType filterType;
  final String filterNameOrCodeValue;
  final StockEntity? lastStock;

  GetStockListEvent({
    required this.pageSize,
    required this.index,
    required this.filterType,
    required this.filterNameOrCodeValue,
    this.lastStock,
  });
}
