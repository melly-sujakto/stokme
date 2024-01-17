part of 'transaction_bloc.dart';

sealed class TransactionState {}

final class TransactionInitial extends TransactionState {}

final class GenerateReceiptFinished extends TransactionInitial {}

final class GetProductListLoading extends TransactionInitial {}

final class GetProductListFailed extends TransactionInitial {}

final class GetProductListLoaded extends TransactionInitial {
  final List<ProductEntity> products;

  GetProductListLoaded(this.products);
}
