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
