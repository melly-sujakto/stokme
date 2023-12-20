import 'dart:async';

import 'package:data_abstraction/entity/product_entity.dart';
import 'package:data_abstraction/entity/sale_entity.dart';
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
    on<CalculatePriceProductEvent>(_onCalculatePriceProductEvent);
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

  FutureOr<void> _onCalculatePriceProductEvent(
    CalculatePriceProductEvent event,
    Emitter<SaleState> emit,
  ) async {
    try {
      // TODO(Melly): move to be core class/place due to relate to price and money
      final totalNet = event.product.saleNet! * event.total;
      final saleEntity = SaleEntity(
        productEntity: event.product,
        // TODO(Melly): should receive from event
        receiptId: 'receiptId',
        total: event.total,
        totalNet: totalNet,
      );
      emit(CalculationSuccess(saleEntity));
    } catch (e) {
      emit(GetProductListFailed());
    }
  }
}
