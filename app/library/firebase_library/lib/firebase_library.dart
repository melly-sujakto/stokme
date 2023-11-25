import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_library/firebase_options.dart';

class FirebaseLibrary {
  FirebaseLibrary();

  late final FirebaseAuth auth;

  Future init() async {
    auth = FirebaseAuth.instanceFor(
      app: await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
    );
  }

  // call in library
  Future<List<Map<String, dynamic>>> getAllData() async {
    final collectionRef = FirebaseFirestore.instance.collection('store');
    final querySnapshot = await collectionRef.get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

// call in library
  Future<Map<String, dynamic>?> getOneData(String code) async {
    final collectionRef = FirebaseFirestore.instance.collection('product');
    final querySnapshot = await collectionRef.doc(code).get();
    return querySnapshot.data();
  }
}
