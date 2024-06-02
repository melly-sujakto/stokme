part of 'supplier_bloc.dart';

sealed class SupplierState {}

final class SupplierInitial extends SupplierState {}

final class GetSuppliersLoading extends SupplierState {}

final class GetSuppliersLoaded extends SupplierState {
  final List<SupplierEntity> suppliers;
  final bool isLastPage;

  GetSuppliersLoaded({
    required this.suppliers,
    required this.isLastPage,
  });
}

final class GetSuppliersFailed extends SupplierState {}
