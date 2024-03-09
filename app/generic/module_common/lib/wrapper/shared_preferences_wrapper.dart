import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SharedPreferencesWrapper extends Uuid {
  final Future<SharedPreferences> _sharedPreference =
      SharedPreferences.getInstance();

  Future<SharedPreferences> getPrefs() async => _sharedPreference;

  Future<void> clear() async {
    await (await _sharedPreference).clear();
  }
}
