import 'dart:async';

import 'package:data_abstraction/entity/product_entity.dart';
import 'package:data_abstraction/entity/receipt_entity.dart';
import 'package:data_abstraction/entity/sale_entity.dart';
import 'package:feature_transaction/domain/usecase/sale_usecase.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:uuid/uuid.dart';

part 'sale_event.dart';
part 'sale_state.dart';

class SaleBloc extends BaseBloc<SaleEvent, SaleState> {
  final SaleUsecase saleUsecase;

  SaleBloc(
    this.saleUsecase,
  ) : super(SaleInitial()) {
    on<GetProductListEvent>(_onGetProductListEvent);
    on<CalculatePriceProductEvent>(_onCalculatePriceProductEvent);
    on<CalculateTotalPriceEvent>(_onCalculateTotalPriceEvent);
    on<GenerateReceiptEvent>(_onGenerateReceiptIdEvent);
    on<SubmitReceiptAndSalesEvent>(_onSubmitReceiptAndSalesEvent);
  }

  late ReceiptEntity receipt;

  FutureOr<void> _onGenerateReceiptIdEvent(
    GenerateReceiptEvent event,
    Emitter<SaleState> emit,
  ) async {
    const uuid = Uuid();
    receipt = ReceiptEntity(
      id: uuid.v4(),
      cash: 0.0,
      change: 0.0,
      totalGross: 0.0,
      discount: 0.0,
      totalNet: 0.0,
      userEmail: await saleUsecase.getUserEmail(),
    );

    emit(GenerateReceiptFinished());
  }

  // TODO(melly): regenerate receipt id and update all sale.receipt_id

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
    // TODO(Melly): move to be core class/place due to relate to price and money
    final totalNet = event.product.saleNet! * event.total;
    final saleEntity = SaleEntity(
      productEntity: event.product,
      receiptId: receipt.id!,
      total: event.total,
      totalNet: totalNet,
    );
    emit(CalculationSuccess(saleEntity));
  }

  FutureOr<void> _onCalculateTotalPriceEvent(
    CalculateTotalPriceEvent event,
    Emitter<SaleState> emit,
  ) async {
    // TODO(Melly): move to be core class/place due to relate to price and money and handle gross, discount, etc
    double totalPrice = 0.0;
    for (final saleEntity in event.saleEntityList) {
      totalPrice += saleEntity.totalNet;
    }

    // update current receipt
    receipt = receipt.copyWith(
      cash: totalPrice,
      totalGross: totalPrice,
      totalNet: totalPrice,
    );

    emit(
      CalculationTotalPriceSuccess(
        saleEntityList: event.saleEntityList,
        receiptEntity: receipt,
      ),
    );
  }

  FutureOr<void> _onSubmitReceiptAndSalesEvent(
    SubmitReceiptAndSalesEvent event,
    Emitter<SaleState> emit,
  ) async {
    emit(SubmitLoading());
    try {
      await saleUsecase.submitReceiptAndSales(
        receiptEntity: receipt,
        saleEntityList: event.saleEntityList,
      );
      emit(SubmitSuccess());
    } catch (e) {
      // TODO(melly): add regenerate receipt id
      emit(SubmitFailed());
    }
  }
}
