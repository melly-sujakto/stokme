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

// TODO(Melly) will remove
  Future<List<Map<String, dynamic>>> getAllData() async {
    final collectionRef = FirebaseFirestore.instance.collection('store');
    final querySnapshot = await collectionRef.get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

// TODO(Melly) will remove
  Future<Map<String, dynamic>?> getOneData(String code) async {
    final collectionRef = FirebaseFirestore.instance.collection('product');
    final querySnapshot = await collectionRef.doc(code).get();
    return querySnapshot.data();
  }

  Future<Map<String, dynamic>?> get({
    required String collectionName,
    required String id,
  }) async {
    final collectionRef = FirebaseFirestore.instance.collection(collectionName);
    final querySnapshot = await collectionRef.doc(id).get();
    return querySnapshot.data();
  }
}
