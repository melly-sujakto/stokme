import 'dart:async';

import 'package:data_abstraction/entity/supplier_entity.dart';
import 'package:feature_supplier/domain/usecase/supplier_usecase.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'supplier_event.dart';
part 'supplier_state.dart';

class SupplierBloc extends BaseBloc<SupplierEvent, SupplierState> {
  final SupplierUsecase supplierUsecase;

  SupplierBloc(
    this.supplierUsecase,
  ) : super(SupplierInitial()) {
    on<GetSuppliersEvent>(_onGetStockListEvent);
    on<UpdateSupplierEvent>(_onUpdateSupplierEvent);
    on<SetInactiveSupplierEvent>(_onSetInactiveSupplierEvent);
  }

  FutureOr<void> _onGetStockListEvent(
    GetSuppliersEvent event,
    Emitter<SupplierState> emit,
  ) async {
    emit(GetSuppliersLoading());
    try {
      final results = await supplierUsecase.getSupplierList(
        filterNameOrCodeValue: event.filterNameOrCodeValue,
        index: event.index,
        pageSize: event.pageSize,
        lastItem: event.lastItem,
      );

      final suppliers = results
          .where(
            (element) => element.name
                .toLowerCase()
                .contains(event.filterNameOrCodeValue.toLowerCase()),
          )
          .toList();

      emit(
        GetSuppliersLoaded(
          suppliers: suppliers,
          isLastPage: results.length < event.pageSize,
        ),
      );
    } catch (e) {
      emit(GetSuppliersFailed());
    }
  }

  FutureOr<void> _onUpdateSupplierEvent(
    UpdateSupplierEvent event,
    Emitter<SupplierState> emit,
  ) async {
    emit(UpdateSupplierLoading());
    try {
      await supplierUsecase.updateSupplier(event.supplier);
      emit(UpdateSupplierSuccess());
    } catch (e) {
      emit(UpdateSupplierFailed());
    }
  }

  FutureOr<void> _onSetInactiveSupplierEvent(
    SetInactiveSupplierEvent event,
    Emitter<SupplierState> emit,
  ) async {
    emit(SetInactiveSupplierLoading());
    try {
      final inactiveSupplier = event.supplier..setInactive();
      await supplierUsecase.updateSupplier(inactiveSupplier);
      emit(SetInactiveSupplierSuccess());
    } catch (e) {
      emit(SetInactiveSupplierFailed());
    }
  }
}
