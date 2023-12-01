import 'package:module_common/common/constant/generic_constants.dart';
import 'package:module_common/common/enum/languages.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

class LanguageUsecase {
  final SharedPreferencesWrapper _sharedPreferencesWrapper;

  LanguageUsecase(this._sharedPreferencesWrapper);

  Future<String> getLanguage() async {
    final prefs = await _sharedPreferencesWrapper.getPrefs();
    final String lang =
        prefs.getString(GenericConstants.languageCode) ?? Languages.id.code;
    return Languages.values.map((e) => e.code).contains(lang)
        ? lang
        : Languages.id.code;
  }

  Future<void> saveLanguageToLocal(String languageCode) async {
    final prefs = await _sharedPreferencesWrapper.getPrefs();
    await prefs.setString(GenericConstants.languageCode, languageCode);
  }
}
