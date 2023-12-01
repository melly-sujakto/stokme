import 'package:feature_dashboard/common/enums/feature.dart';
import 'package:module_common/common/constant/generic_constants.dart';
import 'package:module_common/wrapper/shared_preferences_wrapper.dart';

class HomeUsecase {
  final SharedPreferencesWrapper _sharedPreferencesWrapper;

  HomeUsecase(this._sharedPreferencesWrapper);

  Future<String?> getUserName() async {
    final prefs = await _sharedPreferencesWrapper.getPrefs();
    return prefs.getString(GenericConstants.userName);
  }

  Future<List<Feature>> getAvailableFeatures() async {
    //TODO(Melly): generate features by role
    return <Feature>[];
  }
}
