import 'package:data_abstraction/entity/product_entity.dart';
import 'package:data_abstraction/entity/receipt_entity.dart';
import 'package:data_abstraction/entity/sale_entity.dart';
import 'package:data_abstraction/entity/stock_in_entity.dart';
import 'package:data_abstraction/model/product_model.dart';
import 'package:data_abstraction/model/receipt_model.dart';
import 'package:data_abstraction/model/sale_model.dart';
import 'package:data_abstraction/model/stock_in_model.dart';
import 'package:firebase_library/firebase_library.dart';
import 'package:module_common/common/constant/generic_constants.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

class TransactionUsecase {
  final FirebaseLibrary firebaseLibrary;
  final SharedPreferencesWrapper sharedPreferencesWrapper;

  TransactionUsecase({
    required this.firebaseLibrary,
    required this.sharedPreferencesWrapper,
  });

  final stockInCollectionName = 'stock_in';
  final stockCollectionName = 'stock';
  final productCollectionName = 'product';
  final receiptCollectionName = 'receipt';
  final collectionName = 'sale';

  Future<String> _getStoreId() async {
    final pref = await sharedPreferencesWrapper.getPrefs();
    return pref.getString(GenericConstants.storeId)!;
  }

  // TODO(melly): move to mobile_data project to be shareable
  Future<List<ProductEntity>> getProductList(String filterValue) async {
    final collectionRef = firebaseLibrary.selfQuery(productCollectionName);
    final querySnapshot = await collectionRef
        .where('store_id', isEqualTo: await _getStoreId())
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

  Future<String> getUserName() async {
    final pref = await sharedPreferencesWrapper.getPrefs();
    return pref.getString(GenericConstants.userName)!;
  }

  Future<void> submitReceiptAndSales({
    required ReceiptEntity receiptEntity,
    required List<SaleEntity> saleEntityList,
  }) async {
    // submit receipt
    await _submitReceipt(receiptEntity);
    // submit sales
    await _submitSaleList(saleEntityList);
  }

  Future<void> _submitReceipt(ReceiptEntity receiptEntity) async {
    final data = ReceiptModel.fromEntity(receiptEntity).toFirestoreJson();
    await firebaseLibrary.createDocument(
      collectionName: receiptCollectionName,
      data: data,
      id: receiptEntity.id,
    );
  }

  Future<void> _submitSaleList(List<SaleEntity> saleEntityList) async {
    for (final saleEntity in saleEntityList) {
      final data = SaleModel.fromEntity(saleEntity).toFirestoreJson();
      await firebaseLibrary.createDocument(
        collectionName: collectionName,
        data: data,
      );
    }
  }

  Future<void> submitStockIn(StockInEntity stockIn) async {
    final data = StockInModel.fromEntity(stockIn).toFirestoreJson();
    await firebaseLibrary.createDocument(
      collectionName: stockInCollectionName,
      data: data,
    );

    await _increaseStock(
      productId: stockIn.productEntity.id!,
      totalPcs: stockIn.totalPcs,
    );
  }

  Future<void> _increaseStock({
    required String productId,
    required int totalPcs,
  }) async {
    final collectionRef = firebaseLibrary.selfQuery(stockCollectionName);
    final querySnapshot = await collectionRef
        .where('product_id', isEqualTo: productId)
        .limit(1)
        .get();

    final jsonList = querySnapshot.docs.map((doc) {
      final data = doc.data();
      final id = doc.id;
      data['id'] = id;
      return data;
    }).toList();

    if (jsonList.isEmpty) {
      await firebaseLibrary.createDocument(
        collectionName: stockCollectionName,
        data: {
          'product_id': productId,
          'total_pcs': totalPcs,
        },
      );
    } else {
      await firebaseLibrary.updateDocument(
        collectionName: stockCollectionName,
        id: jsonList.first['id'],
        document: {
          'product_id': productId,
          'total_pcs': jsonList.first['total_pcs'] + totalPcs,
        },
      );
    }
  }

  Future<void> addProduct(ProductEntity productEntity) async {
    await firebaseLibrary.createDocument(
      collectionName: productCollectionName,
      data: ProductModel.fromEntity(productEntity)
          .toFirestoreJson(await _getStoreId()),
    );
  }
}
