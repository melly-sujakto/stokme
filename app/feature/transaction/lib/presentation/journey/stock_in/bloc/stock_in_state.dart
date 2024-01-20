part of 'stock_in_bloc.dart';

sealed class StockInState {}

final class StockInInitial extends StockInState {}

class SubmitStockLoading extends StockInState {}

class SubmitStockError extends StockInState {}

class SubmitStockSuccess extends StockInState {}

class AddProductLoading extends StockInState {}

class AddProductSuccess extends StockInState {}

class AddProductError extends StockInState {}
