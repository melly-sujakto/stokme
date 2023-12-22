part of 'print_bloc.dart';

sealed class PrintEvent {}

class PrintExecuteEvent extends PrintEvent {
  // TODO(melly): wrap to be one entity
  final List<SaleEntity> saleEntityList;
  final ReceiptEntity receiptEntity;
  final String dateText;
  final String timeText;
  final String userName;

  PrintExecuteEvent({
    required this.saleEntityList,
    required this.receiptEntity,
    required this.dateText,
    required this.timeText,
    required this.userName,
  });
}
