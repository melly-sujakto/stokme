import 'package:data_abstraction/entity/product_entity.dart';
import 'package:data_abstraction/model/product_model.dart';
import 'package:firebase_library/firebase_library.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

class ProductUsecase {
  final FirebaseLibrary firebaseLibrary;
  final SharedPreferencesWrapper sharedPreferencesWrapper;

  ProductUsecase({
    required this.firebaseLibrary,
    required this.sharedPreferencesWrapper,
  });

  Future<List<ProductEntity>> getProductList() async {
    const collectionName = 'product';
    final jsonList =
        await firebaseLibrary.getList(collectionName: collectionName);
    return jsonList.map(ProductModel.fromJson).toList();
  }
}
