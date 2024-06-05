import 'dart:async';

import 'package:data_abstraction/entity/product_entity.dart';
import 'package:data_abstraction/entity/stock_in_entity.dart';
import 'package:data_abstraction/entity/supplier_entity.dart';
import 'package:feature_transaction/domain/usecase/transaction_usecase.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'stock_in_event.dart';
part 'stock_in_state.dart';

class StockInBloc extends BaseBloc<StockInEvent, StockInState> {
  final TransactionUsecase transactionUsecase;
  StockInBloc(
    this.transactionUsecase,
  ) : super(StockInInitial()) {
    on<PrepareDataEvent>(_onPrepareDataEvent);
    on<SubmitStockInEvent>(_onSubmitStockInEvent);
    on<AddProductEvent>(_onAddProductEvent);
    on<GetSuppliersEvent>(_onGetSuppliers);
  }

  FutureOr<void> _onPrepareDataEvent(
    PrepareDataEvent event,
    Emitter<StockInState> emit,
  ) async {
    final isAutoActiveScanner =
        await transactionUsecase.getFlagAlwaysUseCameraAsScanner();
    emit(
      StockInInitial(isAutoActiveScanner: isAutoActiveScanner ?? false),
    );
  }

  FutureOr<void> _onSubmitStockInEvent(
    SubmitStockInEvent event,
    Emitter<StockInState> emit,
  ) async {
    emit(SubmitStockLoading());
    try {
      await transactionUsecase.submitStockIn(event.stockInEntity);
      emit(SubmitStockSuccess());
    } catch (e) {
      emit(SubmitStockError());
    }
  }

  FutureOr<void> _onAddProductEvent(
    AddProductEvent event,
    Emitter<StockInState> emit,
  ) async {
    emit(AddProductLoading());
    try {
      await transactionUsecase.addProduct(event.product);
      emit(AddProductSuccess());
    } catch (e) {
      emit(AddProductError());
    }
  }

  FutureOr<void> _onGetSuppliers(
    GetSuppliersEvent event,
    Emitter<StockInState> emit,
  ) async {
    emit(GetSuppliersLoading());
    try {
      final suppliers = await transactionUsecase.getSuppliers();
      emit(GetSuppliersLoaded(suppliers));
    } catch (e) {
      emit(GetSuppliersFailed());
    }
  }
}
