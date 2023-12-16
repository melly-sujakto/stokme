import 'package:data_abstraction/entity/stock_entity.dart';
import 'package:data_abstraction/model/stock_model.dart';
import 'package:firebase_library/firebase_library.dart';
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

  // TODO(Melly): implement index and limit
  Future<List<StockEntity>> getStockList({
    required StockFilterType stockFilterType,
    required String filterNameOrCodeValue,
  }) async {
    final collectionRef = firebaseLibrary.selfQuery(collectionName);
    final querySnapshot = await collectionRef
        .orderBy(
          'total_pcs',
          descending: stockFilterType == StockFilterType.mostStock,
        )
        .get();

    final jsonList = querySnapshot.docs.map((doc) {
      final data = doc.data();
      final id = doc.id;
      data['id'] = id;
      return data;
    }).toList();

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

    return result
        .where(
          (element) =>
              element.productEntity.code
                  .toLowerCase()
                  .contains(filterNameOrCodeValue.toLowerCase()) ||
              element.productEntity.name
                  .toLowerCase()
                  .contains(filterNameOrCodeValue.toLowerCase()),
        )
        .toList();
  }
}
