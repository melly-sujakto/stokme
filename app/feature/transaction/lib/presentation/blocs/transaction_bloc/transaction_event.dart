part of 'transaction_bloc.dart';

sealed class TransactionEvent {}

class GetProductListEvent extends TransactionEvent {
  final String filterValue;
  GetProductListEvent({
    required this.filterValue,
  });
}