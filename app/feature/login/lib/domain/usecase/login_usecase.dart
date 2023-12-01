import 'package:firebase_auth/firebase_auth.dart';
import 'package:module_common/common/constant/generic_constants.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

class LoginUsecase {
  final SharedPreferencesWrapper _sharedPreferencesWrapper;

  LoginUsecase(this._sharedPreferencesWrapper);

  Future<void> saveUserCredentialToLocal(UserCredential userCredential) async {
    final prefs = await _sharedPreferencesWrapper.getPrefs();
    await prefs.setString(
      GenericConstants.userName,
      userCredential.user!.email!,
    );
  }
}
