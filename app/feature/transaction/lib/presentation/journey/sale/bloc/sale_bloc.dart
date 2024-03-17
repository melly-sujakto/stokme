import 'dart:async';

import 'package:data_abstraction/entity/product_entity.dart';
import 'package:data_abstraction/entity/receipt_entity.dart';
import 'package:data_abstraction/entity/sale_entity.dart';
import 'package:feature_transaction/domain/usecase/transaction_usecase.dart';
import 'package:intl/intl.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:uuid/uuid.dart';

part 'sale_event.dart';
part 'sale_state.dart';

class SaleBloc extends BaseBloc<SaleEvent, SaleState> {
  final TransactionUsecase transactionUsecase;

  SaleBloc(
    this.transactionUsecase,
  ) : super(SaleInitial()) {
    on<GetProductListEvent>(_onGetProductListEvent);
    on<CalculatePriceProductEvent>(_onCalculatePriceProductEvent);
    on<CalculateTotalPriceEvent>(_onCalculateTotalPriceEvent);
    on<SetupEvent>(_onSetupEvent);
    on<SubmitReceiptAndSalesEvent>(_onSubmitReceiptAndSalesEvent);
  }

  late ReceiptEntity receipt;
  late String userEmail;
  late String userName;

  FutureOr<void> _onSetupEvent(
    SetupEvent event,
    Emitter<SaleState> emit,
  ) async {
    userEmail = await transactionUsecase.getUserEmail();
    userName = await transactionUsecase.getUserName();
    const uuid = Uuid();
    receipt = ReceiptEntity(
      id: uuid.v4(),
      cash: 0.0,
      change: 0.0,
      totalGross: 0.0,
      discount: 0.0,
      totalNet: 0.0,
      userEmail: userEmail,
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
      final products =
          await transactionUsecase.getProductList(event.filterValue);
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
    final totalNet = event.product.saleNet * event.totalPcs;
    final saleEntity = SaleEntity(
      productEntity: event.product,
      receiptId: receipt.id!,
      totalPcs: event.totalPcs,
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
      await transactionUsecase.submitReceiptAndSales(
        receiptEntity: receipt,
        saleEntityList: event.saleEntityList,
      );
      // TODO(melly): move to an utils
      final dateTimeNow = DateTime.now();
      final dateFormat = DateFormat('EEEE, dd MMMM yyyy');
      final timeFormat = DateFormat('HH:mm');
      final date = dateFormat.format(dateTimeNow);
      final time = timeFormat.format(dateTimeNow);
      emit(
        SubmitSuccess(
          saleEntityList: event.saleEntityList,
          dateText: date,
          timeText: time,
        ),
      );
    } catch (e) {
      // TODO(melly): add regenerate receipt id
      emit(SubmitFailed());
    }
  }
}
