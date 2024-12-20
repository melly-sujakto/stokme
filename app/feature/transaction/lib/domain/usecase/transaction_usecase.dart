import 'dart:async';

import 'package:data_abstraction/entity/product_entity.dart';
import 'package:data_abstraction/entity/receipt_entity.dart';
import 'package:data_abstraction/entity/sale_entity.dart';
import 'package:data_abstraction/entity/stock_in_entity.dart';
import 'package:data_abstraction/entity/store_entity.dart';
import 'package:data_abstraction/entity/supplier_entity.dart';
import 'package:data_abstraction/model/product_model.dart';
import 'package:data_abstraction/model/receipt_model.dart';
import 'package:data_abstraction/model/sale_model.dart';
import 'package:data_abstraction/model/stock_in_model.dart';
import 'package:data_abstraction/model/stock_model.dart';
import 'package:data_abstraction/model/store_model.dart';
import 'package:data_abstraction/model/supplier_model.dart';
import 'package:data_abstraction/repository/product_repository.dart';
import 'package:firebase_library/firebase_library.dart';
import 'package:flutter/material.dart';
import 'package:module_common/common/constant/generic_constants.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

class TransactionUsecase {
  final FirebaseLibrary firebaseLibrary;
  final SharedPreferencesWrapper sharedPreferencesWrapper;
  final ProductRepository productRepository;

  TransactionUsecase({
    required this.firebaseLibrary,
    required this.sharedPreferencesWrapper,
    required this.productRepository,
  });

  final stockInCollectionName = 'stock_in';
  final stockCollectionName = 'stock';
  final productCollectionName = 'product';
  final receiptCollectionName = 'receipt';
  final saleCollectionName = 'sale';
  final supplierCollectionName = 'supplier';

  Future<String> _getStoreId() async {
    final pref = await sharedPreferencesWrapper.getPrefs();
    return pref.getString(GenericConstants.storeId)!;
  }

  Future<int> getUserRole() async {
    final prefs = await sharedPreferencesWrapper.getPrefs();
    final roleId = prefs.getInt(GenericConstants.roleId);
    return roleId!;
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

  Future<ReceiptEntity> submitReceiptAndSales({
    required ReceiptEntity receiptEntity,
    required List<SaleEntity> saleEntityList,
  }) async {
    // submit receipt
    final receipt = await _submitReceipt(receiptEntity);
    // submit sales
    await _submitSaleList(saleEntityList);
    return receipt;
  }

  Future<ReceiptEntity> _submitReceipt(ReceiptEntity receiptEntity) async {
    final data = ReceiptModel.fromEntity(receiptEntity).toFirestoreJson(
      await _getStoreId(),
      isActive: true,
      overridedCreatedAt: DateTime.now(),
      overridedCreatedBy: await _getUserEmail(),
    );
    final id = await firebaseLibrary.createDocument(
      collectionName: receiptCollectionName,
      data: data,
      id: receiptEntity.id,
    );
    final receiptJson = await firebaseLibrary.getById(
      collectionName: receiptCollectionName,
      id: id,
    );
    return ReceiptModel.fromJson(receiptJson!);
  }

  Future<void> _submitSaleList(List<SaleEntity> saleEntityList) async {
    for (final saleEntity in saleEntityList) {
      final data = SaleModel.fromEntity(saleEntity).toFirestoreJson(
        await _getStoreId(),
        isActive: true,
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

  Future<void> submitStockIn(
    StockInEntity stockIn, {
    SupplierEntity? supplierEntity,
    bool isNewSupplier = false,
  }) async {
    if (isNewSupplier) {
      if (supplierEntity == null) {
        // ignore: lines_longer_than_80_chars
        throw Exception('[supplierEntity] should be not null'
            ' if [isNewSupplier] is true');
      }
      final supplierData =
          SupplierModel.fromEntity(supplierEntity).toFirestoreJson(
        await _getStoreId(),
        overridedIsActive: true,
        overridedCreatedAt: DateTime.now(),
        overridedCreatedBy: await getUserEmail(),
      );
      final supplierId = await firebaseLibrary.createDocument(
        collectionName: supplierCollectionName,
        data: supplierData,
      );
      stockIn.supplierId = supplierId;
    }

    final data = StockInModel.fromEntity(stockIn).toFirestoreJson(
      await _getStoreId(),
      isActive: true,
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
        ).toFirestoreJson(
          await _getStoreId(),
          isActive: true,
        ),
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
        ).toFirestoreJson(
          await _getStoreId(),
          isActive: true,
        ),
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
        isActive: true,
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

  Future<List<SaleEntity>> getSalesByReceiptId(String receiptId) async {
    final collectionRef = firebaseLibrary.selfQuery(saleCollectionName);
    final querySnapshot = await collectionRef
        .where(
          'receipt_id',
          isEqualTo: receiptId,
        )
        .get();

    final jsonList = querySnapshot.docs.map((doc) {
      final data = doc.data();
      final id = doc.id;
      data['id'] = id;
      return data;
    }).toList();

    final result = <SaleEntity>[];
    for (final json in jsonList) {
      try {
        final product = await firebaseLibrary.getById(
          collectionName: productCollectionName,
          id: json['product_id'],
        );
        json['product'] = product;
        result.add(SaleModel.fromJson(json));
      } catch (e) {
        // just continue if there is error or product is deleted
      }
    }
    return result;
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

  Future<List<StockInEntity>> getStockInList({
    StockInEntity? lastItem,
    int index = 0,
    int pageSize = 20,
    required DateTimeRange dateTimeRange,
  }) async {
    final collectionRef = firebaseLibrary.selfQuery(stockInCollectionName);
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
      collectionName: stockInCollectionName,
      orderByField: 'created_at',
      decending: true,
      lastDocumentId: lastItem?.id,
      index: index,
      pageSize: pageSize,
    );

    final result = <StockInEntity>[];
    for (final json in jsonList) {
      try {
        final product = await firebaseLibrary.getById(
          collectionName: 'product',
          id: json['product_id'],
        );
        json['product'] = product;
        result.add(StockInModel.fromJson(json));
      } catch (e) {
        // just continue if there is error or product is deleted
      }
    }

    return result;
  }

  Future<List<SupplierEntity>> getSuppliers() async {
    final collectionRef = firebaseLibrary.selfQuery(supplierCollectionName);
    final querySnapshot = await collectionRef
        .where(
          'store_id',
          isEqualTo: await _getStoreId(),
        )
        .where(
          'is_active',
          isEqualTo: true,
        )
        .get();

    final jsonList = querySnapshot.docs.map((doc) {
      final data = doc.data();
      final id = doc.id;
      data['id'] = id;
      return data;
    }).toList();

    final result = jsonList.map(SupplierModel.fromJson).toList();

    return result;
  }
}
