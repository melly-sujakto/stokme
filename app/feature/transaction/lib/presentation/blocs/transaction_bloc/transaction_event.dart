part of 'transaction_bloc.dart';

sealed class TransactionEvent {}

class GetProductListEvent extends TransactionEvent {
  final String filterByCode;

  GetProductListEvent({this.filterByCode = ''});
}
