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

  Future<String> _getStoreId() async {
    final storeId = (await sharedPreferencesWrapper.getPrefs())
        .getString(GenericConstants.storeId);
    return storeId!;
  }

  Future<String> _getUserEmail() async {
    final pref = await sharedPreferencesWrapper.getPrefs();
    return pref.getString(GenericConstants.email)!;
  }

  Future<List<SupplierEntity>> getSupplierList({
    required String filterNameOrCodeValue,
    SupplierEntity? lastItem,
    int index = 0,
    int pageSize = 20,
  }) async {
    final collectionRef = firebaseLibrary.selfQuery(collectionName);
    final initialSelfQuery = collectionRef
        .where(
          'store_id',
          isEqualTo: await _getStoreId(),
        )
        .where(
          'is_active',
          isEqualTo: true,
        );

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

  Future<void> updateSupplier(SupplierEntity supplier) async {
    await firebaseLibrary.updateDocument(
      collectionName: collectionName,
      id: supplier.id!,
      document: SupplierModel.fromEntity(supplier).toFirestoreJson(
        await _getStoreId(),
        overridedIsActive: true,
        overridedUpdatedAt: DateTime.now(),
        overridedUpdatedBy: await _getUserEmail(),
      ),
    );
  }
}
