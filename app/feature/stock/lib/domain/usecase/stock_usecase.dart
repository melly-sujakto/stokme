import 'package:data_abstraction/entity/stock_entity.dart';
import 'package:data_abstraction/model/stock_model.dart';
import 'package:firebase_library/firebase_library.dart';
import 'package:module_common/common/constant/generic_constants.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

enum StockFilterType {
  mostStock,
  lowestStock,
}

class StockUsecase {
  final FirebaseLibrary firebaseLibrary;
  final SharedPreferencesWrapper sharedPreferencesWrapper;

  final collectionName = 'stock';

  StockUsecase({
    required this.firebaseLibrary,
    required this.sharedPreferencesWrapper,
  });

  Future<List<StockEntity>> getStockList({
    required StockFilterType stockFilterType,
    required String filterNameOrCodeValue,
    StockEntity? lastStock,
    int index = 0,
    int pageSize = 20,
  }) async {
    final storeId = (await sharedPreferencesWrapper.getPrefs())
        .getString(GenericConstants.storeId);
    final collectionRef = firebaseLibrary.selfQuery(collectionName);
    final initialSelfQuery =
        collectionRef.where('store_id', isEqualTo: storeId).where(
              'is_active',
              isEqualTo: true,
            );

    final jsonList = await firebaseLibrary.getListPagination(
      initialSelfQuery: initialSelfQuery,
      collectionName: collectionName,
      orderByField: 'total_pcs',
      decending: stockFilterType == StockFilterType.mostStock,
      lastDocumentId: lastStock?.id,
      index: index,
      pageSize: pageSize,
    );

    final result = <StockEntity>[];
    for (final json in jsonList) {
      try {
        final product = await firebaseLibrary.getById(
          collectionName: 'product',
          id: json['product_id'],
        );
        json['product'] = product;
        result.add(StockModel.fromJson(json));
      } catch (e) {
        // just continue if there is error or product is deleted
      }
    }

    return result;
  }
}
