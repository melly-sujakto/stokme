import 'package:data_abstraction/entity/product_entity.dart';
import 'package:data_abstraction/model/product_model.dart';
import 'package:firebase_library/firebase_library.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

class ProductUsecase {
  final FirebaseLibrary firebaseLibrary;
  final SharedPreferencesWrapper sharedPreferencesWrapper;

  final collectionName = 'product';

  ProductUsecase({
    required this.firebaseLibrary,
    required this.sharedPreferencesWrapper,
  });

  Future<List<ProductEntity>> getProductList({
    bool filterByUnsetPrice = false,
  }) async {
    final collectionRef = firebaseLibrary.selfQuery(collectionName);
    final querySnapshot = filterByUnsetPrice
        ? await collectionRef.where('sale_net', isNull: true).get()
        : await collectionRef.get();

    final jsonList = querySnapshot.docs.map((doc) {
      final data = doc.data();
      final id = doc.id;
      data['id'] = id;
      return data;
    }).toList();

    return jsonList.map(ProductModel.fromJson).toList();
  }

  Future<void> updateProduct(ProductEntity productEntity) async {
    await firebaseLibrary.updateDocument(
      collectionName: collectionName,
      id: productEntity.id,
      document: ProductModel.fromEntity(productEntity).toFirestoreJson(),
    );
  }
}
