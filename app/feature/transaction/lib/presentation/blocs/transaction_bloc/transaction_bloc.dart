import 'dart:async';

import 'package:data_abstraction/entity/product_entity.dart';
import 'package:feature_transaction/domain/usecase/transaction_usecase.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends BaseBloc<TransactionEvent, TransactionState> {
  final TransactionUsecase transactionUsecase;

  TransactionBloc(
    this.transactionUsecase,
  ) : super(TransactionInitial()) {
    on<GetProductListEvent>(_onGetProductListEvent);
  }

  FutureOr<void> _onGetProductListEvent(
    GetProductListEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(GetProductListLoading());
    try {
      final products =
          await transactionUsecase.getProductList(event.filterValue);
      emit(GetProductListLoaded(products));
    } catch (e) {
      emit(GetProductListFailed());
    }
  }
}
