import 'package:data_abstraction/entity/product_entity.dart';
import 'package:data_abstraction/model/product_model.dart';
import 'package:firebase_library/firebase_library.dart';
import 'package:module_common/common/constant/generic_constants.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

class ProductUsecase {
  final FirebaseLibrary firebaseLibrary;
  final SharedPreferencesWrapper sharedPreferencesWrapper;

  final collectionName = 'product';

  ProductUsecase({
    required this.firebaseLibrary,
    required this.sharedPreferencesWrapper,
  });

  Future<String> _getStoreId() async {
    final pref = await sharedPreferencesWrapper.getPrefs();
    return pref.getString(GenericConstants.storeId)!;
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
    await firebaseLibrary.createDocument(
      collectionName: collectionName,
      data: ProductModel.fromEntity(productEntity)
          .toFirestoreJson(await _getStoreId()),
    );
  }

  Future<void> updateProduct(ProductEntity productEntity) async {
    await firebaseLibrary.updateDocument(
      collectionName: collectionName,
      id: productEntity.id!,
      document: ProductModel.fromEntity(productEntity)
          .toFirestoreJson(await _getStoreId()),
    );
  }

  Future<void> deleteProduct(String productId) async {
    await firebaseLibrary.deleteDocument(
      collectionName: collectionName,
      id: productId,
    );
  }
}
