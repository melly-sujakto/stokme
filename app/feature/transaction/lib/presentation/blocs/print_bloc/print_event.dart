part of 'print_bloc.dart';

sealed class PrintEvent {}

class PrintExecuteEvent extends PrintEvent {
  final BuildContext context;
  // TODO(melly): wrap to be one entity
  final List<SaleEntity> saleEntityList;
  final ReceiptEntity receiptEntity;
  final String dateText;
  final String timeText;
  final String userName;
  final StoreEntity? storeEntity;

  PrintExecuteEvent(
    this.context, {
    required this.saleEntityList,
    required this.receiptEntity,
    required this.dateText,
    required this.timeText,
    required this.userName,
    this.storeEntity,
  });
}
