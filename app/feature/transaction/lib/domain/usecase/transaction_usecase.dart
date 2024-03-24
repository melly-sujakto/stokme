import 'dart:async';

import 'package:data_abstraction/entity/product_entity.dart';
import 'package:data_abstraction/entity/receipt_entity.dart';
import 'package:data_abstraction/entity/sale_entity.dart';
import 'package:data_abstraction/entity/stock_in_entity.dart';
import 'package:data_abstraction/entity/store_entity.dart';
import 'package:data_abstraction/model/product_model.dart';
import 'package:data_abstraction/model/receipt_model.dart';
import 'package:data_abstraction/model/sale_model.dart';
import 'package:data_abstraction/model/stock_in_model.dart';
import 'package:data_abstraction/model/stock_model.dart';
import 'package:data_abstraction/model/store_model.dart';
import 'package:data_abstraction/repository/printer_repository.dart';
import 'package:data_abstraction/repository/product_repository.dart';
import 'package:firebase_library/firebase_library.dart';
import 'package:flutter/material.dart';
import 'package:module_common/common/constant/generic_constants.dart';
import 'package:module_common/package/bluetooth_print.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

class TransactionUsecase {
  final FirebaseLibrary firebaseLibrary;
  final SharedPreferencesWrapper sharedPreferencesWrapper;
  final PrinterRepository printerRepository;
  final ProductRepository productRepository;

  TransactionUsecase({
    required this.firebaseLibrary,
    required this.sharedPreferencesWrapper,
    required this.printerRepository,
    required this.productRepository,
  });

  final stockInCollectionName = 'stock_in';
  final stockCollectionName = 'stock';
  final productCollectionName = 'product';
  final receiptCollectionName = 'receipt';
  final saleCollectionName = 'sale';

  Future<String> _getStoreId() async {
    final pref = await sharedPreferencesWrapper.getPrefs();
    return pref.getString(GenericConstants.storeId)!;
  }

  Future<String> _getUserEmail() async {
    final pref = await sharedPreferencesWrapper.getPrefs();
    return pref.getString(GenericConstants.email)!;
  }

  Future<bool?> getFlagAlwaysUseCameraAsScanner() async {
    final pref = await sharedPreferencesWrapper.getPrefs();
    return pref.getBool(GenericConstants.alwaysUseCameraAsScanner);
  }

  Future<List<ProductEntity>> getProductList({
    ProductEntity? lastProduct,
    int index = 0,
    int pageSize = 20,
  }) {
    return productRepository.getProductList(
      index: index,
      lastProduct: lastProduct,
      pageSize: pageSize,
    );
  }

  Future<String> getUserEmail() async {
    final pref = await sharedPreferencesWrapper.getPrefs();
    return pref.getString(GenericConstants.email)!;
  }

  Future<String> getUserName() async {
    final pref = await sharedPreferencesWrapper.getPrefs();
    return pref.getString(GenericConstants.userName)!;
  }

  Future<void> submitReceiptAndSales({
    required ReceiptEntity receiptEntity,
    required List<SaleEntity> saleEntityList,
  }) async {
    // submit receipt
    await _submitReceipt(receiptEntity);
    // submit sales
    await _submitSaleList(saleEntityList);
  }

  Future<void> _submitReceipt(ReceiptEntity receiptEntity) async {
    final data = ReceiptModel.fromEntity(receiptEntity).toFirestoreJson(
      await _getStoreId(),
      overridedCreatedAt: DateTime.now(),
      overridedCreatedBy: await _getUserEmail(),
    );
    await firebaseLibrary.createDocument(
      collectionName: receiptCollectionName,
      data: data,
      id: receiptEntity.id,
    );
  }

  Future<void> _submitSaleList(List<SaleEntity> saleEntityList) async {
    for (final saleEntity in saleEntityList) {
      final data = SaleModel.fromEntity(saleEntity).toFirestoreJson(
        await _getStoreId(),
        overridedCreatedAt: DateTime.now(),
        overridedCreatedBy: await _getUserEmail(),
      );
      await firebaseLibrary.createDocument(
        collectionName: saleCollectionName,
        data: data,
      );
      unawaited(
        _updateStock(
          productId: saleEntity.productEntity.id!,
          totalPcs: saleEntity.totalPcs,
          isIncrease: false,
        ),
      );
    }
  }

  Future<void> submitStockIn(StockInEntity stockIn) async {
    final data = StockInModel.fromEntity(stockIn).toFirestoreJson(
      await _getStoreId(),
      overridedCreatedAt: DateTime.now(),
      overridedCreatedBy: await _getUserEmail(),
    );
    await firebaseLibrary.createDocument(
      collectionName: stockInCollectionName,
      data: data,
    );

    await _updateStock(
      productId: stockIn.productEntity.id!,
      totalPcs: stockIn.totalPcs,
      isIncrease: true,
    );
  }

  Future<void> _updateStock({
    required String productId,
    required int totalPcs,
    required bool isIncrease,
  }) async {
    final collectionRef = firebaseLibrary.selfQuery(stockCollectionName);
    final querySnapshot = await collectionRef
        .where('product_id', isEqualTo: productId)
        .limit(1)
        .get();

    final jsonList = querySnapshot.docs.map((doc) {
      final data = doc.data();
      final id = doc.id;
      data['id'] = id;
      return data;
    }).toList();

    if (jsonList.isEmpty) {
      await firebaseLibrary.createDocument(
        collectionName: stockCollectionName,
        data: StockModel.forInitStock(
          productId: productId,
          totalPcs: totalPcs,
          createdAt: DateTime.now(),
          createdBy: await _getUserEmail(),
        ).toFirestoreJson(await _getStoreId()),
      );
    } else {
      final stockJson = jsonList.first;
      await firebaseLibrary.updateDocument(
        collectionName: stockCollectionName,
        id: stockJson['id'],
        document: StockModel.forUpdateStock(
          productId: productId,
          totalPcs: _affectStock(
            currentValue: jsonList.first['total_pcs'],
            affectedValue: totalPcs,
            isIncrease: isIncrease,
          ),
          createdAt: stockJson['created_at'] != null
              ? DateTime.fromMillisecondsSinceEpoch(stockJson['created_at'])
              : DateTime.now(),
          createdBy: stockJson['created_by'] ?? await _getUserEmail(),
          updatedAt: DateTime.now(),
          updatedBy: await _getUserEmail(),
        ).toFirestoreJson(await _getStoreId()),
      );
    }
  }

  int _affectStock({
    required int currentValue,
    required int affectedValue,
    required bool isIncrease,
  }) {
    return isIncrease
        ? currentValue + affectedValue
        : currentValue - affectedValue;
  }

  Future<void> addProduct(ProductEntity productEntity) async {
    await firebaseLibrary.createDocument(
      collectionName: productCollectionName,
      data: ProductModel.fromEntity(productEntity).toFirestoreJson(
        await _getStoreId(),
        overridedCreatedAt: DateTime.now(),
        overridedCreatedBy: await _getUserEmail(),
      ),
    );
  }

  Future<StoreEntity> getStoreDetail() async {
    const collectionName = 'store';
    final prefs = await sharedPreferencesWrapper.getPrefs();
    final storeId = prefs.getString(GenericConstants.storeId);

    final json = await firebaseLibrary.getById(
      collectionName: collectionName,
      id: storeId!,
    );

    return StoreModel.fromJson(json!);
  }

  Future<List<BluetoothDevice>> scanAvailablePrinters() {
    return printerRepository.scan();
  }

  Future<void> startPrint({
    required BluetoothDevice device,
    required List<LineText> lineTexts,
  }) {
    return printerRepository.startPrint(device: device, lineTexts: lineTexts);
  }

  Future<List<ReceiptEntity>> getSaleReceipts({
    ReceiptEntity? lastItem,
    int index = 0,
    int pageSize = 20,
    required DateTimeRange dateTimeRange,
  }) async {
    final collectionRef = firebaseLibrary.selfQuery(receiptCollectionName);
    final initialSelfQuery = collectionRef
        .where('store_id', isEqualTo: await _getStoreId())
        .where(
          'created_at',
          isGreaterThanOrEqualTo: dateTimeRange.start.millisecondsSinceEpoch,
        )
        .where(
          'created_at',
          isLessThanOrEqualTo: dateTimeRange.end.millisecondsSinceEpoch,
        );

    final jsonList = await firebaseLibrary.getListPagination(
      initialSelfQuery: initialSelfQuery,
      collectionName: receiptCollectionName,
      orderByField: 'created_at',
      decending: true,
      lastDocumentId: lastItem?.id,
      index: index,
      pageSize: pageSize,
    );

    return jsonList.map(ReceiptModel.fromJson).toList();
  }
}
