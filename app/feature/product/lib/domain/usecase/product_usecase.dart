import 'dart:async';

import 'package:data_abstraction/entity/product_entity.dart';
import 'package:data_abstraction/model/product_model.dart';
import 'package:data_abstraction/model/stock_model.dart';
import 'package:firebase_library/firebase_library.dart';
import 'package:module_common/common/constant/generic_constants.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

class ProductUsecase {
  final FirebaseLibrary firebaseLibrary;
  final SharedPreferencesWrapper sharedPreferencesWrapper;

  final collectionName = 'product';
  final collectionNameStock = 'stock';

  ProductUsecase({
    required this.firebaseLibrary,
    required this.sharedPreferencesWrapper,
  });

  Future<String> _getStoreId() async {
    final pref = await sharedPreferencesWrapper.getPrefs();
    return pref.getString(GenericConstants.storeId)!;
  }

  Future<String> _getUserEmail() async {
    final pref = await sharedPreferencesWrapper.getPrefs();
    return pref.getString(GenericConstants.email)!;
  }

  Future<List<ProductEntity>> getProductList({
    bool filterByUnsetPrice = false,
    ProductEntity? lastProduct,
    int index = 0,
    int pageSize = 20,
  }) async {
    final collectionRef = firebaseLibrary.selfQuery(collectionName);
    final initialSelfQuery = filterByUnsetPrice
        ? collectionRef
            .where('store_id', isEqualTo: await _getStoreId())
            .where('sale_net', isEqualTo: 0)
        : collectionRef.where('store_id', isEqualTo: await _getStoreId());

    final jsonList = await firebaseLibrary.getListPagination(
      initialSelfQuery: initialSelfQuery,
      collectionName: collectionName,
      orderByField: 'name',
      decending: false,
      lastDocumentId: lastProduct?.id,
      index: index,
      pageSize: pageSize,
    );

    return jsonList.map(ProductModel.fromJson).toList();
  }

  Future<void> addProduct(ProductEntity productEntity) async {
    final productId = await firebaseLibrary.createDocument(
      collectionName: collectionName,
      data: ProductModel.fromEntity(productEntity).toFirestoreJson(
        overridedStoreId: await _getStoreId(),
        overridedCreatedAt: DateTime.now(),
        overridedCreatedBy: await _getUserEmail(),
      ),
    );
    // affect stock
    unawaited(
      _initStockByProductEntity(
        productEntity,
        overridedProductId: productId,
      ),
    );
  }

  Future<void> _initStockByProductEntity(
    ProductEntity productEntity, {
    String? overridedProductId,
  }) async {
    await firebaseLibrary.createDocument(
      collectionName: collectionNameStock,
      data: StockModel(
        totalPcs: 0,
        productEntity: productEntity,
      ).toFirestoreJson(
        await _getStoreId(),
        overridedProductId: overridedProductId,
      ),
    );
  }

  Future<void> updateProduct(ProductEntity productEntity) async {
    await firebaseLibrary.updateDocument(
      collectionName: collectionName,
      id: productEntity.id!,
      document: ProductModel.fromEntity(productEntity).toFirestoreJson(
        overridedUpdatedAt: DateTime.now(),
        overridedUpdatedBy: await _getUserEmail(),
      ),
    );
  }

  Future<void> deleteProduct(String productId) async {
    await firebaseLibrary.deleteDocument(
      collectionName: collectionName,
      id: productId,
    );
    //affect stock
    unawaited(_deleteStockByProductId(productId));
  }

  Future<void> _deleteStockByProductId(String productId) async {
    final stockQSnapshot = await firebaseLibrary
        .selfQuery(collectionNameStock)
        .where('product_id', isEqualTo: productId)
        .limit(1)
        .get();
    final stockId = stockQSnapshot.docs.last.id;
    unawaited(
      firebaseLibrary.deleteDocument(
        collectionName: collectionNameStock,
        id: stockId,
      ),
    );
  }
}
