import 'dart:async';

import 'package:data_abstraction/entity/receipt_entity.dart';
import 'package:data_abstraction/entity/stock_in_entity.dart';
import 'package:feature_transaction/domain/usecase/transaction_usecase.dart';
import 'package:flutter/material.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'transaction_list_event.dart';
part 'transaction_list_state.dart';

class TransactionListBloc
    extends BaseBloc<TransactionListEvent, TransactionListState> {
  TransactionUsecase transactionUsecase;

  TransactionListBloc(this.transactionUsecase)
      : super(GetSaleReceiptsFailed()) {
    on<GetSaleReceipts>(_onGetSaleReceipts);
    on<GetStockInList>(_onGetStockInList);
  }

  FutureOr<void> _onGetSaleReceipts(
    GetSaleReceipts event,
    Emitter<TransactionListState> emit,
  ) async {
    try {
      int index = 0;
      const pageSize = 20;
      final List<ReceiptEntity> rawList = [];
      final List<ReceiptEntity> finalList = [];
      bool alreadyOnLastPage = false;

      while (!alreadyOnLastPage) {
        emit(GetSaleReceiptsLoading());
        final results = await transactionUsecase.getSaleReceipts(
          index: index,
          lastItem: rawList.isNotEmpty ? rawList.last : null,
          pageSize: pageSize,
          dateTimeRange: event.dateTimeRange,
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

  FutureOr<void> _onGetStockInList(
    GetStockInList event,
    Emitter<TransactionListState> emit,
  ) async {
    try {
      int index = 0;
      const pageSize = 20;
      final List<StockInEntity> rawList = [];
      final List<StockInEntity> finalList = [];
      bool alreadyOnLastPage = false;

      while (!alreadyOnLastPage) {
        emit(GetStockInListLoading());
        final results = await transactionUsecase.getStockInList(
          index: index,
          lastItem: rawList.isNotEmpty ? rawList.last : null,
          pageSize: pageSize,
          dateTimeRange: event.dateTimeRange,
        );
        rawList.addAll(results);

        alreadyOnLastPage = results.length < pageSize;

        finalList.addAll(results);

        emit(
          GetStockInListLoaded(
            stockInList: finalList,
            isLastPage: alreadyOnLastPage,
          ),
        );

        index++;
      }
    } catch (e) {
      emit(GetStockInListFailed());
    }
  }
}
