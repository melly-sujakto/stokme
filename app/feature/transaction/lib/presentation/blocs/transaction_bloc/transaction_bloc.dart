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
    try {
      int index = 0;
      const pageSize = 10;
      final List<ProductEntity> rawProductList = [];
      final List<ProductEntity> finalProductList = [];
      bool alreadyOnLastPage = false;

      while (!alreadyOnLastPage) {
        emit(GetProductListLoading());
        final results = await transactionUsecase.getProductList(
          index: index,
          lastProduct: rawProductList.isNotEmpty ? rawProductList.last : null,
          pageSize: pageSize,
        );
        rawProductList.addAll(results);

        alreadyOnLastPage = results.length < pageSize;

        finalProductList.addAll(
          results.where(
            (element) => element.code
                .toLowerCase()
                .contains(event.filterByCode.toLowerCase()),
          ),
        );

        emit(
          GetProductListLoaded(
            products: finalProductList,
            isLastPage: alreadyOnLastPage,
          ),
        );

        index++;
      }
    } catch (e) {
      emit(GetProductListEnd());
    }
  }
}
