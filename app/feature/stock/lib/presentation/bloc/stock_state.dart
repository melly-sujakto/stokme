part of 'stock_bloc.dart';

@immutable
sealed class StockState {}

final class StockInitial extends StockState {}
final class StockLoading extends StockState {}
final class StockLoaded extends StockState {}
