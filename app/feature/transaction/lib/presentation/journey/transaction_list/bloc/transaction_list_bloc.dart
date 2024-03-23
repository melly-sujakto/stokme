import 'dart:async';

import 'package:data_abstraction/entity/receipt_entity.dart';
import 'package:feature_transaction/domain/usecase/transaction_usecase.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'transaction_list_event.dart';
part 'transaction_list_state.dart';

class TransactionListBloc
    extends BaseBloc<TransactionListEvent, TransactionListState> {
  TransactionUsecase transactionUsecase;

  TransactionListBloc(this.transactionUsecase)
      : super(GetSaleReceiptsFailed()) {
    on<GetSaleReceipts>(_onGetSaleReceipts);
  }

  FutureOr<void> _onGetSaleReceipts(
    GetSaleReceipts event,
    Emitter<TransactionListState> emit,
  ) async {
    emit(GetSaleReceiptsLoading());
    try {
      final saleReceipts = await transactionUsecase.GetSaleReceipts();
      emit(GetSaleReceiptsLoaded(saleReceipts));
    } catch (e) {
      emit(GetSaleReceiptsFailed());
    }
  }
}
