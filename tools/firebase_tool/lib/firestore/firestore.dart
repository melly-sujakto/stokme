import 'dart:io';

import 'package:firebase_tool/firestore/firestore_service.dart';

void main(List<String> args) async {
  final service = await FirestoreService().initAndSignIn(
    email: args[0],
    password: args[1],
  );
  await service.fillAllDocumentsWithNewFields(
    collectionName: args[2],
    fields: {},
    keepExistingFields: false,
  );
  exit(0);
}
