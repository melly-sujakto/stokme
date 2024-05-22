import 'package:firebase_tool/config/firebase_config.dart';
import 'package:firedart/firedart.dart';
import 'package:uuid/v4.dart';

class FirestoreService {
  Future<FirestoreService> initAndSignIn({
    required String email,
    required String password,
  }) async {
    FirebaseAuth.initialize(FirebaseConfig.apiKey, VolatileStore());
    Firestore.initialize(FirebaseConfig.projectId);
    FirebaseConfig.auth = FirebaseAuth.instance;
    // Monitor sign-in state
    FirebaseConfig.auth.signInState
        .listen((state) => print("Signed ${state ? "in" : "out"}"));
    await FirebaseConfig.auth.signIn(email, password);
    var user = await FirebaseConfig.auth.getUser();
    print('Signed in user with email: ${user.email}');
    return this;
  }

  Future<void> signOut() async {
    FirebaseConfig.auth.signOut();
    FirebaseConfig.auth.close();

    // Allow some time to get the signed out event
    await Future.delayed(Duration(milliseconds: 100));
    Firestore.instance.close();
  }

  Future<Document> getDocument({
    required String collectionName,
    required String documentId,
  }) async {
    var ref = Firestore.instance.collection(collectionName);
    return ref.document(documentId).get();
  }

  Future<List<Document>> getDocuments({
    required String collectionName,
  }) async {
    final ref = Firestore.instance.collection(collectionName);
    return ref.get();
  }

  Future<void> createDocument({
    required String collectionName,
    String? documentId,
    required Map<String, dynamic> data,
  }) async {
    final ref = Firestore.instance.collection(collectionName);
    final docId = documentId ?? UuidV4().generate();
    final rawDocument = ref.document(docId);
    print('Saving Document:\nid: $docId\ndata: $data\n');
    final savedDocument = await rawDocument.create(data);

    print(
      'Saved Document:\nid: ${savedDocument.id}\ndata: ${savedDocument.map}\n',
    );
  }

  Future<void> updateDocument({
    required String collectionName,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    final ref = Firestore.instance.collection(collectionName);

    final rawDocument = ref.document(documentId);
    print('Updating Document:\nid: $documentId\ndata: $data\n');
    await rawDocument.update(data);

    print('Updated Document:\nid: $documentId\ndata: $data\n');
  }

  Future<void> fillAllDocumentsWithNewFields({
    required String collectionName,
    required Map<String, dynamic> fields,
    bool keepExistingFields = true,
  }) async {
    final documents = await getDocuments(collectionName: collectionName);

    for (var doc in documents) {
      final data = doc.map;
      final newFields = {...fields};

      if (keepExistingFields) {
        print('before remove: $newFields');
        // remove existing field on newFields, so existing field should be kept
        for (var e in data.keys) {
          newFields.remove(e);
          print('removed on: $e');
        }
        print('after remove: $newFields');
      }

      final newData = {...data, ...newFields};
      await updateDocument(
        collectionName: collectionName,
        documentId: doc.id,
        data: newData,
      );
    }
    print(
      'Finished fill all documents on \ncollection:$collectionName \ndata: $fields',
    );
  }
}
