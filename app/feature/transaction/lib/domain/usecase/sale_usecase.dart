import 'package:data_abstraction/entity/product_entity.dart';
import 'package:data_abstraction/model/product_model.dart';
import 'package:firebase_library/firebase_library.dart';
import 'package:module_common/common/constant/generic_constants.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

class SaleUsecase {
  final FirebaseLibrary firebaseLibrary;
  final SharedPreferencesWrapper sharedPreferencesWrapper;

  SaleUsecase({
    required this.firebaseLibrary,
    required this.sharedPreferencesWrapper,
  });

  final productCollectionName = 'product';

  // TODO(melly): move to mobile_data project to be shareable
  Future<List<ProductEntity>> getProductList(String filterValue) async {
    final collectionRef = firebaseLibrary.selfQuery(productCollectionName);
    final querySnapshot = await collectionRef
        .where('code', isGreaterThanOrEqualTo: filterValue)
        .where('code', isLessThan: '${filterValue}z')
        .limit(5)
        .get();

    final jsonList = querySnapshot.docs.map((doc) {
      final data = doc.data();
      final id = doc.id;
      data['id'] = id;
      return data;
    }).toList();

    return jsonList.map(ProductModel.fromJson).toList();
  }

  Future<String> getUserEmail() async {
    final pref = await sharedPreferencesWrapper.getPrefs();
    return pref.getString(GenericConstants.email)!;
  }
}
