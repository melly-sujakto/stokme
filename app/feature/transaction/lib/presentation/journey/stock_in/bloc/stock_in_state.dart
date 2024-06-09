part of 'stock_in_bloc.dart';

sealed class StockInState {}

final class StockInInitial extends StockInState {
  final bool isAutoActiveScanner;
  final String userEmail;

  StockInInitial({
    this.isAutoActiveScanner = false,
    this.userEmail = '',
  });
}

class SubmitStockLoading extends StockInState {}

class SubmitStockError extends StockInState {}

class SubmitStockSuccess extends StockInState {}

class AddProductLoading extends StockInState {}

class AddProductSuccess extends StockInState {}

class AddProductError extends StockInState {}

class GetSuppliersLoading extends StockInState {}

class GetSuppliersLoaded extends StockInState {
  final List<SupplierEntity> suppliers;

  GetSuppliersLoaded(this.suppliers);
}

class GetSuppliersFailed extends StockInState {}
