import 'dart:async';

import 'package:data_abstraction/entity/stock_in_entity.dart';
import 'package:feature_transaction/domain/usecase/transaction_usecase.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'stock_in_event.dart';
part 'stock_in_state.dart';

class StockInBloc extends BaseBloc<StockInEvent, StockInState> {
  final TransactionUsecase transactionUsecase;
  StockInBloc(
    this.transactionUsecase,
  ) : super(StockInInitial()) {
    on<SubmitStockInEvent>(_onSubmitStockInEvent);
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
}
