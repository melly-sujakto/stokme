import 'dart:async';

import 'package:data_abstraction/entity/product_entity.dart';
import 'package:feature_transaction/domain/usecase/sale_usecase.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'sale_event.dart';
part 'sale_state.dart';

class SaleBloc extends BaseBloc<SaleEvent, SaleState> {
  final SaleUsecase saleUsecase;

  SaleBloc(
    this.saleUsecase,
  ) : super(SaleInitial()) {
    on<GetProductListEvent>(_onGetProductListEvent);
  }

  FutureOr<void> _onGetProductListEvent(
    GetProductListEvent event,
    Emitter<SaleState> emit,
  ) async {
    emit(GetProductListLoading());
    try {
      final products = await saleUsecase.getProductList(event.filterValue);
      emit(GetProductListLoaded(products));
    } catch (e) {
      emit(GetProductListFailed());
    }
  }
}
