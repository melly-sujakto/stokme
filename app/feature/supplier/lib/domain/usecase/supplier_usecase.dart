import 'package:data_abstraction/entity/supplier_entity.dart';
import 'package:data_abstraction/model/supplier_model.dart';
import 'package:firebase_library/firebase_library.dart';
import 'package:module_common/common/constant/generic_constants.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

class SupplierUsecase {
  final FirebaseLibrary firebaseLibrary;
  final SharedPreferencesWrapper sharedPreferencesWrapper;

  final collectionName = 'supplier';

  SupplierUsecase({
    required this.firebaseLibrary,
    required this.sharedPreferencesWrapper,
  });

  Future<List<SupplierEntity>> getSupplierList({
    required String filterNameOrCodeValue,
    SupplierEntity? lastItem,
    int index = 0,
    int pageSize = 20,
  }) async {
    final storeId = (await sharedPreferencesWrapper.getPrefs())
        .getString(GenericConstants.storeId);
    final collectionRef = firebaseLibrary.selfQuery(collectionName);
    final initialSelfQuery =
        collectionRef.where('store_id', isEqualTo: storeId);

    final jsonList = await firebaseLibrary.getListPagination(
      initialSelfQuery: initialSelfQuery,
      collectionName: collectionName,
      orderByField: 'name',
      lastDocumentId: lastItem?.id,
      index: index,
      pageSize: pageSize,
    );

    final result = jsonList.map(SupplierModel.fromJson).toList();

    return result;
  }
}
