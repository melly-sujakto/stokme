part of 'supplier_bloc.dart';

sealed class SupplierEvent {}

class GetSuppliersEvent extends SupplierEvent {
  final int pageSize;
  final int index;
  final String filterNameOrCodeValue;
  final SupplierEntity? lastItem;

  GetSuppliersEvent({
    this.pageSize = 20,
    required this.index,
    required this.filterNameOrCodeValue,
    this.lastItem,
  });
}
