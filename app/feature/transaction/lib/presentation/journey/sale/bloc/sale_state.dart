part of 'sale_bloc.dart';

sealed class SaleState {}

final class SaleInitial extends SaleState {
  final bool isAutoActiveScanner;

  SaleInitial({this.isAutoActiveScanner = false});
}

final class GenerateReceiptFinished extends SaleState {}

final class CalculationSuccess extends SaleState {
  final SaleEntity saleEntity;

  CalculationSuccess(this.saleEntity);
}

final class CalculationTotalPriceSuccess extends SaleState {
  final List<SaleEntity> saleEntityList;
  final ReceiptEntity receiptEntity;

  CalculationTotalPriceSuccess({
    required this.saleEntityList,
    required this.receiptEntity,
  });
}

final class SubmitLoading extends SaleState {}

final class SubmitSuccess extends SaleState {
  // TODO(melly): wrap to be one entity
  final List<SaleEntity> saleEntityList;
  final String dateText;
  final String timeText;

  SubmitSuccess({
    required this.saleEntityList,
    required this.dateText,
    required this.timeText,
  });
}

final class SubmitFailed extends SaleState {}
