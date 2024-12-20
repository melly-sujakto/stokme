import 'dart:async';

import 'package:data_abstraction/entity/product_entity.dart';
import 'package:data_abstraction/model/product_model.dart';
import 'package:data_abstraction/model/stock_model.dart';
import 'package:data_abstraction/repository/product_repository.dart';
import 'package:firebase_library/firebase_library.dart';
import 'package:module_common/common/constant/generic_constants.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

class ProductUsecase {
  final FirebaseLibrary firebaseLibrary;
  final SharedPreferencesWrapper sharedPreferencesWrapper;
  final ProductRepository productRepository;

  final collectionName = 'product';
  final collectionNameStock = 'stock';

  ProductUsecase({
    required this.firebaseLibrary,
    required this.sharedPreferencesWrapper,
    required this.productRepository,
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
  }) {
    return productRepository.getProductList(
      filterByUnsetPrice: filterByUnsetPrice,
      index: index,
      lastProduct: lastProduct,
      pageSize: pageSize,
    );
  }

  Future<void> addProduct(ProductEntity productEntity) async {
    final productId = await firebaseLibrary.createDocument(
      collectionName: collectionName,
      data: ProductModel.fromEntity(productEntity).toFirestoreJson(
        await _getStoreId(),
        isActive: true,
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
        isActive: true,
        overridedProductId: overridedProductId,
        overridedCreatedAt: DateTime.now(),
        overridedCreatedBy: await _getUserEmail(),
      ),
    );
  }

  Future<void> updateProduct(ProductEntity productEntity) async {
    await firebaseLibrary.updateDocument(
      collectionName: collectionName,
      id: productEntity.id!,
      document: ProductModel.fromEntity(productEntity).toFirestoreJson(
        await _getStoreId(),
        isActive: true,
        overridedUpdatedAt: DateTime.now(),
        overridedUpdatedBy: await _getUserEmail(),
      ),
    );
  }

  Future<void> deleteProduct(ProductEntity productEntity) async {
    await firebaseLibrary.updateDocument(
      collectionName: collectionName,
      id: productEntity.id!,
      document: ProductModel.fromEntity(productEntity).toFirestoreJson(
        await _getStoreId(),
        isActive: false,
        overridedUpdatedAt: DateTime.now(),
        overridedUpdatedBy: await _getUserEmail(),
      ),
    );
    //affect stock
    unawaited(_deleteStockByProductId(productEntity.id!));
  }

  Future<void> _deleteStockByProductId(String productId) async {
    final stockQSnapshot = await firebaseLibrary
        .selfQuery(collectionNameStock)
        .where('product_id', isEqualTo: productId)
        .limit(1)
        .get();
    final stockId = stockQSnapshot.docs.last.id;
    final data = stockQSnapshot.docs.last.data();

    unawaited(
      firebaseLibrary.updateDocument(
        collectionName: collectionNameStock,
        id: stockId,
        document: StockModel.fromJson(data).toFirestoreJson(
          await _getStoreId(),
          isActive: false,
          overridedUpdatedAt: DateTime.now(),
          overridedUpdatedBy: await _getUserEmail(),
        ),
      ),
    );
  }
}
