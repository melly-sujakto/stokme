import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseLibrary {
  FirebaseLibrary();

  late final FirebaseAuth auth;

  Future init(FirebaseOptions firebaseOptions) async {
    auth = FirebaseAuth.instanceFor(
      app: await Firebase.initializeApp(
        options: firebaseOptions,
      ),
    );
  }

  Future<Map<String, dynamic>?> getById({
    required String collectionName,
    required String id,
  }) async {
    final collectionRef = FirebaseFirestore.instance.collection(collectionName);
    final querySnapshot = await collectionRef.doc(id).get();
    final data = querySnapshot.data();
    data?['id'] = id;
    return data;
  }

  Future<List<Map<String, dynamic>>> getList(String collectionName) async {
    final collectionRef = FirebaseFirestore.instance.collection(collectionName);
    final querySnapshot = await collectionRef.get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      final id = doc.id;
      data['id'] = id;
      return data;
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getListPagination({
    Query<Map<String, dynamic>>? initialSelfQuery,
    required String collectionName,
    required String orderByField,
    bool decending = false,
    String? lastDocumentId,
    int index = 0,
    int pageSize = 20,
  }) async {
    if (index < 0) {
      throw Exception('[$runtimeType][getListPagination] index should be '
          'positive number');
    }
    if (index > 0 && lastDocumentId == null) {
      throw Exception(
          '[$runtimeType][getListPagination] last document should not null'
          'when index is more than 0');
    }

    final collectionRef = FirebaseFirestore.instance.collection(collectionName);

    late final QuerySnapshot<Map<String, dynamic>> indexDataSnapshot;
    if (index == 0) {
      indexDataSnapshot = await collectionRef
          .orderBy(
            orderByField,
            descending: decending,
          )
          .limit(1)
          .get();
    } else {
      // TODO(Melly): simplify, will be better when just call get() one time
      final lastDocument = await collectionRef.doc(lastDocumentId).get();
      indexDataSnapshot = await collectionRef
          .orderBy(
            orderByField,
            descending: decending,
          )
          .limit(1)
          .startAfterDocument(lastDocument)
          .get();
    }

    final indexData = indexDataSnapshot.docs.last;

    late final QuerySnapshot<Map<String, dynamic>> querySnapshot;
    if (initialSelfQuery == null) {
      querySnapshot = await collectionRef
          .orderBy(
            orderByField,
            descending: decending,
          )
          .startAtDocument(indexData)
          .limit(pageSize)
          .get();
    } else {
      querySnapshot = await initialSelfQuery
          .orderBy(
            orderByField,
            descending: decending,
          )
          .startAtDocument(indexData)
          .limit(pageSize)
          .get();
    }

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      final id = doc.id;
      data['id'] = id;
      return data;
    }).toList();
  }

  CollectionReference<Map<String, dynamic>> selfQuery(String collectionName) {
    return FirebaseFirestore.instance.collection(collectionName);
  }

  Future<void> updateDocument({
    required String collectionName,
    required String id,
    required Map<String, dynamic> document,
  }) async {
    final collectionRef = FirebaseFirestore.instance.collection(collectionName);
    await collectionRef.doc(id).update(document);
  }

  Future<void> createDocument({
    required String collectionName,
    required Map<String, dynamic> data,
    String? id,
  }) async {
    final collectionRef = FirebaseFirestore.instance.collection(collectionName);
    if (id != null) {
      // check is does exist or not
      final querySnapshot = await collectionRef.doc(id).get();
      final existingData = querySnapshot.data();
      if (existingData != null) {
        throw Exception('Data does exist');
      }
      await collectionRef.doc(id).set(data).onError(
        (e, _) {
          throw Exception('Error writing document: $e');
        },
      );
    } else {
      await collectionRef.add(data);
    }
  }

  Future<void> deleteDocument({
    required String collectionName,
    required String id,
  }) async {
    final collectionRef = FirebaseFirestore.instance.collection(collectionName);
    await collectionRef.doc(id).delete();
  }

// TODO(Melly): will remove
  Future<List<Map<String, dynamic>>> getAllData() async {
    final collectionRef = FirebaseFirestore.instance.collection('store');
    final querySnapshot = await collectionRef.get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

// TODO(Melly): will remove
  Future<Map<String, dynamic>?> getOneData(String code) async {
    final collectionRef = FirebaseFirestore.instance.collection('product');
    final querySnapshot = await collectionRef.doc(code).get();
    return querySnapshot.data();
  }
}
