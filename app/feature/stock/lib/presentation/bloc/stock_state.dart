part of 'stock_bloc.dart';

sealed class StockState {}

final class StockInitial extends StockState {}

final class StockLoading extends StockState {}

final class StockFailed extends StockState {}

final class StockLoaded extends StockState {
  final List<StockEntity> stockList;

  StockLoaded(this.stockList);
}