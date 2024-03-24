part of 'transaction_list_bloc.dart';

sealed class TransactionListEvent {}

class GetSaleReceipts extends TransactionListEvent {
  final DateTimeRange dateTimeRange;

  GetSaleReceipts({
    required this.dateTimeRange,
  });
}

class GetStockInList extends TransactionListEvent {
  final DateTimeRange dateTimeRange;

  GetStockInList({
    required this.dateTimeRange,
  });
}
