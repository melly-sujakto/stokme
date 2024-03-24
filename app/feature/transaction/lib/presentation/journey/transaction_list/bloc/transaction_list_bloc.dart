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
    try {
      int index = 0;
      const pageSize = 1;
      final List<ReceiptEntity> rawList = [];
      final List<ReceiptEntity> finalList = [];
      bool alreadyOnLastPage = false;

      while (!alreadyOnLastPage) {
        emit(GetSaleReceiptsLoading());
        final results = await transactionUsecase.getSaleReceipts(
          index: index,
          lastItem: rawList.isNotEmpty ? rawList.last : null,
          pageSize: pageSize,
        );
        rawList.addAll(results);

        alreadyOnLastPage = results.length < pageSize;

        finalList.addAll(results);

        emit(
          GetSaleReceiptsLoaded(
            saleReceipts: finalList,
            isLastPage: alreadyOnLastPage,
          ),
        );

        index++;
      }
    } catch (e) {
      emit(GetSaleReceiptsFailed());
    }
  }
}
