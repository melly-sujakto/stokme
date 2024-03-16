import 'dart:async';

import 'package:data_abstraction/entity/stock_entity.dart';
import 'package:feature_stock/domain/usecase/stock_usecase.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends BaseBloc<StockEvent, StockState> {
  final StockUsecase stockUsecase;
  StockBloc(
    this.stockUsecase,
  ) : super(StockInitial()) {
    on<GetStockListEvent>(_onGetStockListEvent);
  }

  FutureOr<void> _onGetStockListEvent(
    GetStockListEvent event,
    Emitter<StockState> emit,
  ) async {
    emit(StockLoading());
    try {
      final results = await stockUsecase.getStockList(
        stockFilterType: event.filterType,
        filterNameOrCodeValue: event.filterNameOrCodeValue,
        index: event.index,
        pageSize: event.pageSize,
        lastStock: event.lastStock,
      );
      
      final stockList = results
          .where(
            (element) =>
                element.productEntity.code
                    .toLowerCase()
                    .contains(event.filterNameOrCodeValue.toLowerCase()) ||
                element.productEntity.name
                    .toLowerCase()
                    .contains(event.filterNameOrCodeValue.toLowerCase()),
          )
          .toList();

      emit(
        StockLoaded(
          stockList: stockList,
          isLastPage: results.length < event.pageSize,
        ),
      );
    } catch (e) {
      emit(StockFailed());
    }
  }
}
