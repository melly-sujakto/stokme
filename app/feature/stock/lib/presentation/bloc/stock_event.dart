part of 'stock_bloc.dart';

sealed class StockEvent {}

class GetStockListEvent extends StockEvent {
  final int limit;
  final int index;
  final StockFilterType filterType;
  final String filterNameOrCodeValue;

  GetStockListEvent({
    required this.limit,
    required this.index,
    required this.filterType,
    required this.filterNameOrCodeValue,
  });
}
