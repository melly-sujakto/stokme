import 'package:firebase_library/firebase_library.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

class StockUsecase {
  final FirebaseLibrary firebaseLibrary;
  final SharedPreferencesWrapper sharedPreferencesWrapper;

  final collectionName = 'supplier';

  StockUsecase({
    required this.firebaseLibrary,
    required this.sharedPreferencesWrapper,
  });
}
