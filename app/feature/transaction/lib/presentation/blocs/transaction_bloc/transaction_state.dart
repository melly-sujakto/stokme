part of 'transaction_bloc.dart';

sealed class TransactionState {}

final class TransactionInitial extends TransactionState {}

final class GenerateReceiptFinished extends TransactionInitial {}

final class GetProductListLoading extends TransactionInitial {}

final class GetProductListEnd extends TransactionInitial {}

final class GetProductListLoaded extends TransactionInitial {
  final List<ProductEntity> products;
  final bool isLastPage;

  GetProductListLoaded({
    required this.products,
    required this.isLastPage,
  });
}

final class GetProductListLoadedOnLastPage extends GetProductListLoaded {
  GetProductListLoadedOnLastPage({
    required super.products,
    required super.isLastPage,
  });
}
