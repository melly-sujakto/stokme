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
    on<UpdateStockInDataEvent>(_onUpdateStockInDataEvent);
    on<SubmitStockInEvent>(_onSubmitStockInEvent);
    on<AddProductEvent>(_onAddProductEvent);
    on<GetSuppliersEvent>(_onGetSuppliers);
  }

  StockInEntity stockInEntity = StockInEntity(
    productEntity: ProductEntity(code: '', name: '', saleNet: 0),
    totalPcs: 0,
    purchaseNet: 0,
    userName: '',
    userEmail: '',
  );

  void reset() {
    stockInEntity = StockInEntity(
      productEntity: ProductEntity(code: '', name: '', saleNet: 0),
      totalPcs: 0,
      purchaseNet: 0,
      userName: '',
      userEmail: '',
    );
    add(UpdateStockInDataEvent(stockInEntity));
  }

  FutureOr<void> _onPrepareDataEvent(
    PrepareDataEvent event,
    Emitter<StockInState> emit,
  ) async {
    stockInEntity = stockInEntity.copyWith(
      userEmail: await transactionUsecase.getUserEmail(),
      userName: await transactionUsecase.getUserName(),
    );
    final isAutoActiveScanner =
        await transactionUsecase.getFlagAlwaysUseCameraAsScanner();
    emit(
      StockInInitial(
        isAutoActiveScanner: isAutoActiveScanner ?? false,
      ),
    );
  }

  FutureOr<void> _onUpdateStockInDataEvent(
    UpdateStockInDataEvent event,
    Emitter<StockInState> emit,
  ) async {
    stockInEntity = event.stockInEntity;
    emit(UpdateDataSuccess(stockInEntity));
  }

  FutureOr<void> _onSubmitStockInEvent(
    SubmitStockInEvent event,
    Emitter<StockInState> emit,
  ) async {
    emit(SubmitStockLoading());
    try {
      await transactionUsecase.submitStockIn(
        stockInEntity,
        supplierEntity: event.supplierEntity,
        isNewSupplier: event.isNewSupplier,
      );
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
