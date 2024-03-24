part of 'transaction_list_bloc.dart';

sealed class TransactionListState {}

final class TransactionListInitial extends TransactionListState {}

final class GetSaleReceiptsLoading extends TransactionListState {}

final class GetSaleReceiptsFailed extends TransactionListState {}

final class GetSaleReceiptsLoaded extends TransactionListState {
  final List<ReceiptEntity> saleReceipts;
  final bool isLastPage;

  GetSaleReceiptsLoaded({required this.saleReceipts, required this.isLastPage});
}
