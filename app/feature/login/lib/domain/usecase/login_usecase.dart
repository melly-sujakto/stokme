import 'package:data_abstraction/entity/user_entity.dart';
import 'package:data_abstraction/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_library/firebase_library.dart';
import 'package:module_common/common/constant/generic_constants.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

class LoginUsecase {
  final FirebaseLibrary firebaseLibrary;
  final SharedPreferencesWrapper sharedPreferencesWrapper;

  LoginUsecase({
    required this.sharedPreferencesWrapper,
    required this.firebaseLibrary,
  });

  Future<void> saveUserCredentialToLocal(String email) async {
    // should be not null, since will be called after user logged in
    final user = await getUserDetail(email);

    final prefs = await sharedPreferencesWrapper.getPrefs();
    // set user
    await prefs.setString(GenericConstants.userName, user!.name);
    await prefs.setString(GenericConstants.email, email);
    await prefs.setString(GenericConstants.phone, user.phone);
    await prefs.setInt(GenericConstants.roleId, user.roleId);
    await prefs.setString(GenericConstants.storeId, user.storeId);
  }

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final userCredential =
        await firebaseLibrary.auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential;
  }

  Future<User?> checkLoginStatus() async {
    return firebaseLibrary.auth.currentUser;
  }

  Future<UserEntity?> getUserDetail(String email) async {
    const collectionName = 'user';

    final json = await firebaseLibrary.getById(
      collectionName: collectionName,
      id: email,
    );
    if (json == null) {
      return null;
    }
    json['email'] = email;

    return UserModel.fromJson(json);
  }
}
